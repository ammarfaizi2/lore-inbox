Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVBAC7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVBAC7y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 21:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVBAC7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 21:59:54 -0500
Received: from bay19-f22.bay19.hotmail.com ([64.4.53.72]:27082 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261513AbVBAC7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 21:59:02 -0500
Message-ID: <BAY19-F22AC3732395ECB04CFBE85C57D0@phx.gbl>
X-Originating-IP: [220.224.26.239]
X-Originating-Email: [nitin_gupta_mail@hotmail.com]
From: "Nitin Gupta" <nitin_gupta_mail@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Patch for CIFS vfs
Date: Tue, 01 Feb 2005 08:28:58 +0530
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_7404_435e_61ce"
X-OriginalArrivalTime: 01 Feb 2005 02:59:00.0597 (UTC) FILETIME=[FAD5CA50:01C50809]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_7404_435e_61ce
Content-Type: text/plain; format=flowed

This is the patch for CIFS ver 1.22 (included with linux-2.6.8). This 
improves cifs vfs client file read performance by 10-15%.

Changes were made only to a single file in cifs tree 
(/usr/src/linux/fs/cifs/file.c)

The function cifs_readpages() is modifed and cifs_readpages_threadfn() has 
been added.

Current implementation sends a read request to server and waits for data to 
arrive before sending the next read request.
This has been modified to implement sending back-to-back multiple read 
requests using single connection stream.
It is implemented by starting multiple threads with each one sending a read 
request for different parts of file.


Still to do --
-- submit multiple read requests in parallel using _multiple connections_
-- dynamically control no. of threads operating depending on server response 
time


I have tested it to be quite stable with good performance gain.

Please give test results and comments to --

nitin_gupta_mail@hotmail.com
Nitin Gupta

Thanks

_________________________________________________________________
Manage information better. Optimise your tasks. 
http://www.microsoft.com/india/office/experience/  Experience MS Office 
System.

------=_NextPart_000_7404_435e_61ce
Content-Type: text/plain; name="patch-cifs"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="patch-cifs"

--- linux/fs/cifs/file.c	2005-01-16 17:50:00.081086264 +0530
+++ /home/temp/file-en.c	2005-01-16 17:48:49.441825064 +0530
@@ -1,4 +1,8 @@
-/*
+/*	 <modified file.c - by Nitin Gupta (nitin_gupta_mail@hotmail.com)>
+ *	 modified function cifs_readpages()
+ *	 added function cifs_readpages_threadfn()
+ *
+ *
  *   fs/cifs/file.c
  *
  *   vfs operations that deal with files
@@ -35,6 +39,38 @@
#include "cifs_debug.h"
#include "cifs_fs_sb.h"

+#include <asm/atomic.h>
+#include <asm/spinlock.h>
+#include <linux/kthread.h>
+
+#define FIN_WAIT 1
+#define FIN_ERR  3
+
+struct per_thread_data {
+	int interrupted;
+	wait_queue_head_t wq_h;
+
+	int xid, rsize_in_pages;
+	struct file *file;
+	struct address_space *mapping;
+	struct list_head *page_list;
+	struct pagevec lru_pvec;
+	struct cifsFileInfo * open_file;
+	struct cifs_sb_info *cifs_sb;
+	struct cifsTconInfo *pTcon;
+
+	spinlock_t sl_page_pool;
+	spinlock_t sl_cache_lock;
+	struct semaphore threadsem;
+	volatile struct list_head *page_pool;
+
+	atomic_t pages_left;
+	atomic_t read_state;
+	atomic_t thread_count;
+	atomic_t threads_required;
+};
+
+
int
cifs_open(struct inode *inode, struct file *file)
{
@@ -1093,49 +1129,109 @@ static void cifs_copy_cache_pages(struct
}


-static int
-cifs_readpages(struct file *file, struct address_space *mapping,
-		struct list_head *page_list, unsigned num_pages)
+int cifs_readpages_threadfn (void *data)
{
-	int rc = -EACCES;
-	int xid;
-	loff_t offset;
-	struct page * page;
-	struct cifs_sb_info *cifs_sb;
-	struct cifsTconInfo *pTcon;
-	int bytes_read = 0;
-	unsigned int read_size,i;
-	char * smb_read_data = NULL;
-	struct smb_com_read_rsp * pSMBr;
-	struct pagevec lru_pvec;
-	struct cifsFileInfo * open_file;

-	xid = GetXid();
-	if (file->private_data == NULL) {
-		FreeXid(xid);
-		return -EBADF;
+int i, rc;
+unsigned num_pages;
+char *smb_read_data = NULL;
+struct page *page;
+
+struct list_head page_list_head;
+struct list_head *page_list;
+
+
+struct per_thread_data *t = (struct per_thread_data *)data;
+
+while ( atomic_read(&t->pages_left) > 0 )
+{
+
+	INIT_LIST_HEAD(&page_list_head);
+
+	if (atomic_read(&t->read_state) == FIN_ERR || (t->interrupted == 1)) 
break;
+
+
+spin_lock(&t->sl_page_pool);
+
+	if (atomic_read(&t->threads_required) < atomic_read(&t->thread_count)) {
+		spin_unlock(&t->sl_page_pool);
+		atomic_dec(&t->thread_count);
+		return 0;
+	}
+
+	if (atomic_read(&t->read_state) == FIN_ERR) /* if error */ {
+		spin_unlock(&t->sl_page_pool);
+		break;
	}
-	open_file = (struct cifsFileInfo *)file->private_data;
-	cifs_sb = CIFS_SB(file->f_dentry->d_sb);
-	pTcon = cifs_sb->tcon;
+	/*	if(atomic_read(&t->thread_count)<=1) {
+			atomic_dec(&t->thread_count);
+			up(&t->threadsem);
+			return 0;
+		} else {
+			atomic_dec(&t->thread_count);
+			return 0;
+		}
+	}*/
+
+	if (atomic_read(&t->read_state) == FIN_WAIT) { /* endwait state */
+		if (atomic_read(&t->thread_count) <= 1) {
+			spin_unlock(&t->sl_page_pool);
+			atomic_dec(&t->thread_count);
+			up(&t->threadsem);
+			return 0;
+		} else {
+			atomic_dec(&t->thread_count);
+			spin_unlock(&t->sl_page_pool);
+			return 0;
+		}
+	}
+
+	//printk("\npages_left = %d\n", atomic_read(&t->pages_left));
+
+	if (atomic_read(&t->pages_left) >= t->rsize_in_pages) {
+		num_pages = t->rsize_in_pages;
+	} else {
+		num_pages = atomic_read(&t->pages_left);
+	}
+
+	//num_pages = 1;
+	atomic_sub(num_pages, &t->pages_left);
+
+	for (i=0; i<num_pages; i++) {
+		page = list_entry(t->page_pool, struct page, lru);
+		t->page_pool = t->page_pool->prev;
+		list_del(&page->lru);
+		list_add(&page->lru, &page_list_head);
+	}
+
+	//printk("\npages_left now = %d\n", atomic_read(&t->pages_left));
+
+	if ( atomic_read(&t->pages_left) <= 0 )
+		atomic_set(&t->read_state, FIN_WAIT); /* set endwait state */

-	pagevec_init(&lru_pvec, 0);
+spin_unlock(&t->sl_page_pool);

-	for(i = 0;i<num_pages;) {
+	page_list = &page_list_head;
+
+	for(i = 0; i < num_pages;) {
+		struct page *tmp_page;
		unsigned contig_pages;
-		struct page * tmp_page;
		unsigned long expected_index;
-
-		if(list_empty(page_list)) {
-			break;
-		}
+		loff_t offset;
+		unsigned int read_size;
+		int bytes_read;
+		struct smb_com_read_rsp * pSMBr;
+
+		smb_read_data = NULL;
+
+
		page = list_entry(page_list->prev, struct page, lru);
		offset = (loff_t)page->index << PAGE_CACHE_SHIFT;

		/* count adjacent pages that we will read into */
		contig_pages = 0;
-		expected_index = list_entry(page_list->prev,struct page,lru)->index;
-		list_for_each_entry_reverse(tmp_page,page_list,lru) {
+		expected_index = list_entry(page_list->prev,struct page,lru)->index;
+		list_for_each_entry_reverse(tmp_page, page_list,lru) {
			if(tmp_page->index == expected_index) {
				contig_pages++;
				expected_index++;
@@ -1143,83 +1239,81 @@ cifs_readpages(struct file *file, struct
				break;
			}
		}
-		if(contig_pages + i >  num_pages) {
-			contig_pages = num_pages - i;
-		}
-
-		/* for reads over a certain size could initiate async read ahead */
+		//contig_pages = 1;
+

		read_size = contig_pages * PAGE_CACHE_SIZE;
-		/* Read size needs to be in multiples of one page */
-		read_size = min_t(const unsigned int,read_size,cifs_sb->rsize & 
PAGE_CACHE_MASK);
+
+		//printk("\nread_size = %d\n", read_size);
+
+		if (atomic_read(&t->read_state) == FIN_ERR) break;

		rc = -EAGAIN;
		while(rc == -EAGAIN) {
-			if ((open_file->invalidHandle) && (!open_file->closePend)) {
-				rc = cifs_reopen_file(file->f_dentry->d_inode,
-					file, TRUE);
-				if(rc != 0)
+			if ((t->open_file->invalidHandle) && (!t->open_file->closePend)) {
+				rc = cifs_reopen_file(t->file->f_dentry->d_inode
+							, t->file, TRUE);
+				if(rc != 0) {
+					atomic_set((&t->read_state), FIN_ERR);
					break;
+				}
			}

-			rc = CIFSSMBRead(xid, pTcon,
-				open_file->netfid,
+			rc = CIFSSMBRead(t->xid, t->pTcon,
+				t->open_file->netfid,
				read_size, offset,
				&bytes_read, &smb_read_data);
-			/* BB need to check return code here */
-			if(rc== -EAGAIN) {
+
+			if(rc == -EAGAIN) {
				if(smb_read_data) {
					cifs_buf_release(smb_read_data);
					smb_read_data = NULL;
				}
			}
		}
+
+		if (atomic_read(&t->read_state) == FIN_ERR) break;
+
		if ((rc < 0) || (smb_read_data == NULL)) {
			cFYI(1,("Read error in readpages: %d",rc));
+
			/* clean up remaing pages off list */
-			while (!list_empty(page_list) && (i < num_pages)) {
-				page = list_entry(page_list->prev, struct page, lru);
-				list_del(&page->lru);
-				page_cache_release(page);
-			}
+			atomic_set(&t->read_state, FIN_ERR);
			break;
		} else if (bytes_read > 0) {
			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
-			cifs_copy_cache_pages(mapping, page_list, bytes_read,
-				smb_read_data + 4 /* RFC1001 hdr */ +
-				le16_to_cpu(pSMBr->DataOffset), &lru_pvec);
+			//printk("\nbefore cache\n");
+			spin_lock(&t->sl_cache_lock);
+
+			if (atomic_read(&t->read_state) == FIN_ERR) {
+				spin_unlock(&t->sl_cache_lock);
+				break;
+			}
+			cifs_copy_cache_pages(t->mapping, page_list,
+				bytes_read, smb_read_data + 4 /* RFC1001 hdr */
+			 	+ le16_to_cpu(pSMBr->DataOffset),
+				 &t->lru_pvec);
+
+			spin_unlock(&t->sl_cache_lock);
+			//printk("\nafter cache\n");

			i +=  bytes_read >> PAGE_CACHE_SHIFT;
#ifdef CONFIG_CIFS_STATS
-			atomic_inc(&pTcon->num_reads);
-			spin_lock(&pTcon->stat_lock);
-			pTcon->bytes_read += bytes_read;
-			spin_unlock(&pTcon->stat_lock);
+			atomic_inc(&t->pTcon->num_reads);
+			spin_lock(&t->pTcon->stat_lock);
+			t->pTcon->bytes_read += bytes_read;
+			spin_unlock(&t->pTcon->stat_lock);
#endif
			if((int)(bytes_read & PAGE_CACHE_MASK) != bytes_read) {
-				cFYI(1,("Partial page %d of %d read to cache",i++,num_pages));
+				cFYI(1,("Partial page %d of %d read to cache",
+								i, num_pages));

				i++; /* account for partial page */

-				/* server copy of file can have smaller size than client */
-				/* BB do we need to verify this common case ? this case is ok -
-				if we are at server EOF we will hit it on next read */
-
-			/* while(!list_empty(page_list) && (i < num_pages)) {
-					page = list_entry(page_list->prev,struct page, list);
-					list_del(&page->list);
-					page_cache_release(page);
-				}
-				break; */
			}
		} else {
			cFYI(1,("No bytes read (%d) at offset %lld . Cleaning remaining pages 
from readahead list",bytes_read,offset));
-			/* BB turn off caching and do new lookup on file size at server? */
-			while (!list_empty(page_list) && (i < num_pages)) {
-				page = list_entry(page_list->prev, struct page, lru);
-				list_del(&page->lru);
-				page_cache_release(page); /* BB removeme - replace with zero of page? 
*/
-			}
+			atomic_set(&t->read_state, FIN_ERR);
			break;
		}
		if(smb_read_data) {
@@ -1227,20 +1321,169 @@ cifs_readpages(struct file *file, struct
			smb_read_data = NULL;
		}
		bytes_read = 0;
-	}

-	pagevec_lru_add(&lru_pvec);
+		if (atomic_read(&t->read_state) == FIN_ERR) break;
+
+	} //end of for(i = 0;i<num_pages;)
+

-/* need to free smb_read_data buf before exit */
+	if (atomic_read(&t->read_state) == FIN_ERR) break;
+
+	if (atomic_read(&t->read_state) == FIN_WAIT) {
+		if (atomic_read(&t->thread_count) <= 1) {
+			if(smb_read_data) {
+				cifs_buf_release(smb_read_data);
+				smb_read_data = NULL;
+			}
+			atomic_dec(&t->thread_count);
+			up(&t->threadsem);
+			return 0;
+		} else {
+			atomic_dec(&t->thread_count);
+			return 0;
+		}
+	}
+} // end of while
+
+if (atomic_read(&t->read_state) == FIN_ERR || (t->interrupted == 1))  { /* 
if error */
	if(smb_read_data) {
		cifs_buf_release(smb_read_data);
		smb_read_data = NULL;
-	}
+	}
+	atomic_dec(&t->thread_count);
+	//printk("\nin tfn thread_count: %d\n", atomic_read(&t->thread_count));
+	if ( (t->interrupted == 1) && (atomic_read(&t->thread_count) <= 0) )
+		wake_up(&t->wq_h);
+	up(&t->threadsem);
+	return 0;
+}

-	FreeXid(xid);
+atomic_dec(&t->thread_count);
+//up(&t->threadsem);
+return 0;
+
+}
+
+
+
+static int
+cifs_readpages(struct file *file, struct address_space *mapping,
+		struct list_head *page_list, unsigned num_pages)
+{
+	int i, init_threads, xid, rc = -EACCES;
+	struct page *page;
+	struct per_thread_data thread_data;
+
+	/* some hard-coded rules to set initial no of threads
+	 * no of threads are then later controlled by some
+	 * other function which changes threads_required var
+	 * to change no of threads running.
+	 */
+
+	/* setting rsize to higher values at mount time inc performance */
+	if (num_pages <= 4 )
+		init_threads = 1;
+	else if (num_pages <= 8)
+		init_threads = 4;
+	else init_threads = 8;
+	// init_threads = 8;
+
+
+	/* setting all the data to be passed to threads */
+	xid = GetXid();
+	thread_data.xid = xid;
+	thread_data.sl_page_pool = SPIN_LOCK_UNLOCKED;
+	thread_data.sl_cache_lock = SPIN_LOCK_UNLOCKED;
+	thread_data.file = file;
+	thread_data.mapping = mapping;
+	thread_data.page_pool = page_list->prev;
+
+
+	thread_data.open_file = (struct cifsFileInfo *)file->private_data;
+	thread_data.cifs_sb = CIFS_SB(file->f_dentry->d_sb);
+	thread_data.pTcon = thread_data.cifs_sb->tcon;
+	thread_data.rsize_in_pages = (thread_data.cifs_sb->rsize) >> 
PAGE_CACHE_SHIFT;
+	atomic_set(&thread_data.pages_left, num_pages);
+
+	thread_data.interrupted = 0;
+	init_waitqueue_head(&thread_data.wq_h);
+
+	/* read_state var --
+	 * START (0)    : start the thread
+	 * FIN_WAIT (1) : a thread has reached EOF
+	 * FIN_END  (3) : some error occured during read
+	 */
+	atomic_set(&thread_data.read_state, 0);
+
+	/* keep track of current no of threads */
+	atomic_set(&thread_data.thread_count, init_threads);
+
+	/* var: threads_required - current no of threads required.
+	 * This var is meant to be modified by some external
+	 * function which determines current no of threads req
+	 * acc to some criteria (such as variation in RTT over
+	 * a certain period) and set it to this var.
+	 * Threads read this var and stop if required.
+	 * Increase in no of threads (if reqd) is work for the
+	 * external function.
+	 * Any such external function is not yet implemented.
+	 */
+	atomic_set(&thread_data.threads_required, init_threads);
+
+
+	pagevec_init(&thread_data.lru_pvec, 0);
+
+	if (file->private_data == NULL) {
+		FreeXid(thread_data.xid);
+		return -EBADF;
+	}
+
+	sema_init(&thread_data.threadsem, 1);
+
+	down_interruptible(&thread_data.threadsem);
+
+	for (i=0; i<init_threads; i++)
+		kthread_run(&cifs_readpages_threadfn, &thread_data, "cifsThread");
+
+	if(down_interruptible(&thread_data.threadsem)) {
+		thread_data.interrupted = 1;
+		atomic_set(&thread_data.read_state, FIN_ERR);
+		printk("\nCIFS: readpages interrupted by signal\n");
+		sleep_on(&thread_data.wq_h);
+
+		while(!list_empty(page_list)) {
+			page = list_entry(page_list->prev,struct page, lru);
+			list_del(&page->lru);
+			page_cache_release(page);
+		}
+		pagevec_lru_add(&thread_data.lru_pvec);
+		FreeXid(thread_data.xid);
+		return -ERESTARTSYS;
+	}
+
+
+	up(&thread_data.threadsem);
+	rc = 0;
+	if (atomic_read(&thread_data.read_state) == FIN_ERR) {
+		rc = -EACCES;
+		printk("\nCIFS: some error occured during reading\n");
+		wait_event_interruptible(thread_data.wq_h, 
(atomic_read(&thread_data.thread_count) <= 0) );
+		while(!list_empty(page_list)) {
+			page = list_entry(page_list->prev,struct page, lru);
+			list_del(&page->lru);
+			page_cache_release(page);
+		}
+	}
+
+	pagevec_lru_add(&thread_data.lru_pvec);
+
+	FreeXid(thread_data.xid);
	return rc;
}

+
+
+
static int cifs_readpage_worker(struct file *file, struct page *page, loff_t 
* poffset)
{
	char * read_data;


------=_NextPart_000_7404_435e_61ce--
