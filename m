Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282511AbSA2Fmd>; Tue, 29 Jan 2002 00:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287647AbSA2FmY>; Tue, 29 Jan 2002 00:42:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57617 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S282511AbSA2FmO>;
	Tue, 29 Jan 2002 00:42:14 -0500
Message-ID: <3C56348C.F516A2DB@zip.com.au>
Date: Mon, 28 Jan 2002 21:35:08 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
In-Reply-To: <20020128153210.A3032@nevyn.them.org> <3C55BC89.EDE3105C@zip.com.au>, <3C55BC89.EDE3105C@zip.com.au> <20020128161900.A9071@nevyn.them.org> <3C55C2AB.AE73A75D@zip.com.au>,
		<3C55C2AB.AE73A75D@zip.com.au>; from akpm@zip.com.au on Mon, Jan 28, 2002 at 01:29:15PM -0800 <20020129005451.H1309@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> Well, I think your earlier suggestion to bale out with an error if an
> invalid page is found sounds like the cleaner fix (possibly in function
> of yet another bitflag, so if somebody wants to get the nearby pages
> regardless of an invalid pages somewhere, it can).
> 

I find it rather hard to decide about this.  get_user_pages()
leaves null page pointers in the page[] array for invalid
pages, and that's a reasonable API, as long as all callers
are actually aware of it....

In the O_DIRECT case, the kernel does not crash, because
brw_kiovec() does:

                        map  = iobuf->maplist[pageind];
                        if (!map) {
                                err = -EFAULT;
                                goto finished;
                        }

However, I think it _would_ crash if the first entry in the maplist[]
was non-null, and the second is null, because that would cause
generic_file_direct_IO() to call mark_dirty_kiobuf(), and
mark_dirty_kiobuf() forgets to check for NULL page *'s in the maplist[].

Given the difficulty of testing all this, and the dubious benefit
in allowing a holey maplist[], I'm inclined to just disallow it
in 2.4.   What do you think?



--- linux-2.4.18-pre7/mm/memory.c	Fri Dec 21 11:19:23 2001
+++ linux-akpm/mm/memory.c	Mon Jan 28 16:26:47 2002
@@ -453,6 +453,7 @@ int get_user_pages(struct task_struct *t
 		vma = find_extend_vma(mm, start);
 
 		if ( !vma ||
+		     (vma->vm_flags & VM_IO) ||
 		    (!force &&
 		     	((write && (!(vma->vm_flags & VM_WRITE))) ||
 		    	 (!write && (!(vma->vm_flags & VM_READ))) ) )) {
@@ -486,8 +487,9 @@ int get_user_pages(struct task_struct *t
 				/* FIXME: call the correct function,
 				 * depending on the type of the found page
 				 */
-				if (pages[i])
-					page_cache_get(pages[i]);
+				if (!pages[i])
+					goto bad_page;
+				page_cache_get(pages[i]);
 			}
 			if (vmas)
 				vmas[i] = vma;
@@ -497,7 +499,19 @@ int get_user_pages(struct task_struct *t
 		} while(len && start < vma->vm_end);
 		spin_unlock(&mm->page_table_lock);
 	} while(len);
+out:
 	return i;
+
+	/*
+	 * We found an invalid page in the VMA.  Release all we have
+	 * so far and fail.
+	 */
+bad_page:
+	spin_unlock(&mm->page_table_lock);
+	while (i--)
+		page_cache_release(pages[i]);
+	i = -EFAULT;
+	goto out;
 }
 
 /*
