Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263972AbUEMIGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUEMIGd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 04:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263928AbUEMIGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 04:06:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:41151 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263939AbUEMIFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 04:05:50 -0400
Date: Thu, 13 May 2004 01:04:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ebiederm@xmission.com, rddunlap@osdl.org, davidm@hpl.hp.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
Message-Id: <20040513010427.0e4fe22c.akpm@osdl.org>
In-Reply-To: <20040513084931.A6858@infradead.org>
References: <m17jvhoa6g.fsf@ebiederm.dsl.xmission.com>
	<20040512143233.0ee0405a.rddunlap@osdl.org>
	<16546.41076.572371.307153@napali.hpl.hp.com>
	<20040512152815.76280eac.akpm@osdl.org>
	<16546.42537.765495.231960@napali.hpl.hp.com>
	<20040512161603.44c50cec.akpm@osdl.org>
	<20040513053051.A5286@infradead.org>
	<m1lljwsvxr.fsf@ebiederm.dsl.xmission.com>
	<20040513083306.A6631@infradead.org>
	<20040513003727.4026699a.akpm@osdl.org>
	<20040513084931.A6858@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, May 13, 2004 at 12:37:27AM -0700, Andrew Morton wrote:
> > The (old) kexec patch I have here implements the API which is described at
> > http://lwn.net/Articles/15468/.  I doubt if it changed?
> 
> That API looks sane to me.

yup.  Here's the syscall itself, btw:

+/*
+ * Exec Kernel system call: for obvious reasons only root may call it.
+ * 
+ * This call breaks up into three pieces.  
+ * - A generic part which loads the new kernel from the current
+ *   address space, and very carefully places the data in the
+ *   allocated pages.
+ *
+ * - A generic part that interacts with the kernel and tells all of
+ *   the devices to shut down.  Preventing on-going dmas, and placing
+ *   the devices in a consistent state so a later kernel can
+ *   reinitialize them.
+ *
+ * - A machine specific part that includes the syscall number
+ *   and the copies the image to it's final destination.  And
+ *   jumps into the image at entry.
+ *
+ * kexec does not sync, or unmount filesystems so if you need
+ * that to happen you need to do that yourself.
+ */
+struct kimage *kexec_image = 0;
+
+asmlinkage long sys_kexec_load(unsigned long entry, unsigned long nr_segments, 
+	struct kexec_segment *segments, unsigned long flags)
+{

+struct kexec_segment {
+	void *buf;
+	size_t bufsz;
+	void *mem;
+	size_t memsz;
+};

