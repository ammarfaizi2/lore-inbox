Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbTKTBMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 20:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbTKTBMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 20:12:36 -0500
Received: from holomorphy.com ([199.26.172.102]:32683 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264196AbTKTBMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 20:12:33 -0500
Date: Wed, 19 Nov 2003 17:12:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031120011209.GZ22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>,
	linux-kernel@vger.kernel.org
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar> <20031120002119.GA7875@localhost> <20031119170233.2619ba81.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119170233.2619ba81.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose Luis Domingo Lopez <linux-kernel@24x7linux.com> wrote:
>> PS2: trying to "recompile" vmmon and vmnet again and starting VMware,
>> when tried to boot some guest OS I got the following in the logs:
>> kernel BUG at mm/memory.c:793!

On Wed, Nov 19, 2003 at 05:02:33PM -0800, Andrew Morton wrote:
> err, this is due to pagefault-accounting-fix.patch.  Looks like vmware has
> its own pagefault handler and Bill didn't update vmware ;)
> Bill, can we take those BUGs out of there and just do some sane default
> thing?

Here it is.


-- wli


diff -prauN mm4-2.6.0-test9-1/arch/i386/mm/fault.c mm4-2.6.0-test9-default-1/arch/i386/mm/fault.c
--- mm4-2.6.0-test9-1/arch/i386/mm/fault.c	2003-11-19 00:07:03.000000000 -0800
+++ mm4-2.6.0-test9-default-1/arch/i386/mm/fault.c	2003-11-19 17:07:44.000000000 -0800
@@ -343,9 +343,6 @@ good_area:
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, write)) {
-		case VM_FAULT_MINOR:
-			tsk->min_flt++;
-			break;
 		case VM_FAULT_MAJOR:
 			tsk->maj_flt++;
 			break;
@@ -353,8 +350,10 @@ good_area:
 			goto do_sigbus;
 		case VM_FAULT_OOM:
 			goto out_of_memory;
+		case VM_FAULT_MINOR:
 		default:
-			BUG();
+			tsk->min_flt++;
+			break;
 	}
 
 	/*
diff -prauN mm4-2.6.0-test9-1/mm/memory.c mm4-2.6.0-test9-default-1/mm/memory.c
--- mm4-2.6.0-test9-1/mm/memory.c	2003-11-19 00:07:15.000000000 -0800
+++ mm4-2.6.0-test9-default-1/mm/memory.c	2003-11-19 17:07:56.000000000 -0800
@@ -779,9 +779,6 @@ int get_user_pages(struct task_struct *t
 			while (!(map = follow_page(mm, start, write))) {
 				spin_unlock(&mm->page_table_lock);
 				switch (handle_mm_fault(mm,vma,start,write)) {
-				case VM_FAULT_MINOR:
-					tsk->min_flt++;
-					break;
 				case VM_FAULT_MAJOR:
 					tsk->maj_flt++;
 					break;
@@ -789,8 +786,10 @@ int get_user_pages(struct task_struct *t
 					return i ? i : -EFAULT;
 				case VM_FAULT_OOM:
 					return i ? i : -ENOMEM;
+				case VM_FAULT_MINOR:
 				default:
-					BUG();
+					tsk->min_flt++;
+					break;
 				}
 				spin_lock(&mm->page_table_lock);
 			}
