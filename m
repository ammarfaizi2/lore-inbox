Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290676AbSAYNgt>; Fri, 25 Jan 2002 08:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290675AbSAYNgg>; Fri, 25 Jan 2002 08:36:36 -0500
Received: from sushi.toad.net ([162.33.130.105]:26518 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S290671AbSAYNg1>;
	Fri, 25 Jan 2002 08:36:27 -0500
Subject: proc_file_read bug?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 25 Jan 2002 08:36:32 -0500
Message-Id: <1011965794.1338.6.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't understand this part of proc_file_read() in 
fs/proc/generic.c:

                /* This is a hack to allow mangling of file pos independent
                 * of actual bytes read.  Simply place the data at page,
                 * return the bytes, and set `start' to the desired offset
                 * as an unsigned int. - Paul.Russell@rustcorp.com.au
                 */
                n -= copy_to_user(buf, start < page ? page : start, n);
                if (n == 0) {
                        if (retval == 0)
                                retval = -EFAULT;
                        break;
                }

                *ppos += start < page ? (long)start : n; /* Move down the file */
                nbytes -= n;
                buf += n;
                retval += n;

When start >= page, we copy n bytes beginning at start and
increase *ppos by n.  Makes sense.  But what happens when
start < page?  We will copy n bytes starting at page, then
increase *ppos by start!!  What sense does that make?  If
there's cleverness happening here, someone please document it.

For your convenience, I append the whole existing proc_file_read
function below.
--
Thomas

static ssize_t
proc_file_read(struct file * file, char * buf, size_t nbytes, loff_t *ppos)
{
	struct inode * inode = file->f_dentry->d_inode;
	char 	*page;
	ssize_t	retval=0;
	int	eof=0;
	ssize_t	n, count;
	char	*start;
	struct proc_dir_entry * dp;

	dp = (struct proc_dir_entry *) inode->u.generic_ip;
	if (!(page = (char*) __get_free_page(GFP_KERNEL)))
		return -ENOMEM;

	while ((nbytes > 0) && !eof)
	{
		count = MIN(PROC_BLOCK_SIZE, nbytes);

		start = NULL;
		if (dp->get_info) {
			/*
			 * Handle backwards compatibility with the old net
			 * routines.
			 */
			n = dp->get_info(page, &start, *ppos, count);
			if (n < count)
				eof = 1;
		} else if (dp->read_proc) {
			n = dp->read_proc(page, &start, *ppos,
					  count, &eof, dp->data);
		} else
			break;

		if (!start) {
			/*
			 * For proc files that are less than 4k
			 */
			start = page + *ppos;
			n -= *ppos;
			if (n <= 0)
				break;
			if (n > count)
				n = count;
		}
		if (n == 0)
			break;	/* End of file */
		if (n < 0) {
			if (retval == 0)
				retval = n;
			break;
		}
		
		/* This is a hack to allow mangling of file pos independent
 		 * of actual bytes read.  Simply place the data at page,
 		 * return the bytes, and set `start' to the desired offset
 		 * as an unsigned int. - Paul.Russell@rustcorp.com.au
		 */
 		n -= copy_to_user(buf, start < page ? page : start, n);
		if (n == 0) {
			if (retval == 0)
				retval = -EFAULT;
			break;
		}

		*ppos += start < page ? (long)start : n; /* Move down the file */
		nbytes -= n;
		buf += n;
		retval += n;
	}
	free_page((unsigned long) page);
	return retval;
}




