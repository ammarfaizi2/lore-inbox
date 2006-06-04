Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWFDDlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWFDDlj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 23:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWFDDli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 23:41:38 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:43792 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751485AbWFDDlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 23:41:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=dJJN0HaKvsmuKb0qozQqtiuTdAIaLTgnJ4XSY/PZCMsjaCqqjOhTSh9/N+Kip7ECPIOG+f3KuHUQpGOM6Fx5IsaRbKcWDyGD7PrcYrdUVMcsrYKfIXUiVMR3WaouX/Re5JY79PZA4u4gRMix7i5fryAVgV2cWeu8uwwRRIGLKSg=
Subject: [PATCHSET] block: fix PIO cache coherency bug, take 2
In-Reply-To: 
X-Mailer: git-send-email
Date: Sun, 4 Jun 2006 12:41:19 +0900
Message-Id: <1149392479501-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: Jens Axboe <axboe@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       rmk@arm.linux.org.uk, lkml <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all.

Here's another round of block PIO cache coherency fix patchset.  The
previous try[1] was rejected because flush_dcache_page() was excessive
and couldn't be called from irq context.  A new cachetlb interface has
been introduced - flush_kernel_dcache_page(), which is only
responsible for flushing the kernel mapping and safe to call from irq
context.  The function is implemented only for parisc.  This patchset
adds implementation for arm.

blk kmap wrappers have been dropped and calls to
flush_kernel_dcache_page() have been directly added.  Because
flush_kernel_dcache_page() hasn't been implemented on many
architectures, converting to such wrappers breaks cache coherency for
such architectures.  kmap should be updated after all archtectures
with aliasing caches implement flush_kernel_dcache_page().

Russell, can you please verify arm's flush_kernel_dcache_page()?  I
tried to implement flush_anon_page() too but didn't know what to do
with anon_vma object.  It seems that a call to
__cpuc_flush_user_range() should do the job but it requires
vma->vm_flags to see whether it's an executable page.  To access vma
from anon mapped page, page->mapping:anon_vma->lock should be grabbed
and probably the first vma on the list can be used, which is kind of
complex.  I think the options here are...

* adding vma argument to flush_anon_page()
* always flush for the worst vm_flags

I have only compile tested.  Please verify this fixes the coherency
problem on arm.

Jens, if everyone is happy with this, can you push this patchset
through blk tree?  As this change only adds calls to
flush_kernel_dcache_page() which is currently implement only on parisc
and arm, I think including this fix into 2.6.17 shouldn't cause too
much trouble.

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.kernel/367509


