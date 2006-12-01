Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967549AbWLAPrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967549AbWLAPrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 10:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967556AbWLAPrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 10:47:36 -0500
Received: from web56515.mail.re3.yahoo.com ([66.196.97.44]:53847 "HELO
	web56515.mail.re3.yahoo.com") by vger.kernel.org with SMTP
	id S967534AbWLAPrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 10:47:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=m0xk4Y8qYRux7/bTpTxgDp+hq9WjSCxyHbXRgVfXeOfSsmjhqQ7zhsW+B/8PUNfDa77L1Gn6nXeSY7Jr9skBCqYvoqS5AmdG1M6rLGp+wTL4m43Mthrkha6/VQLQxzRWzMQofM++nVsyTTL4NkZc3rrT83l0glEQ5B8oc59vqpA=;
X-YMail-OSG: ebuwztkVM1k5LAZoS_3W4JkMvj7UdxMDBtecZYk3ZCHWGnijfxvMGGURjWTr2jIwSQW_UE2_mtN0Jpz9JBxPHizccBR9LMozuOhV_xjciLUV7PnepaYhBJ40W62tlCs5LGRTKNOK
Date: Fri, 1 Dec 2006 07:47:34 -0800 (PST)
From: linux err <linux_err@yahoo.com>
Subject: Re: Core file size?
To: linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490612010640t7ed7119bj57f45c8b47289719@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <236282.74568.qm@web56515.mail.re3.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixed it.

http://lkml.org/lkml/2005/6/13/204

The ELF core dump code has one use of off_t when
writing out segments.  Some
of the segments may be passed the 2GB limit of an
off_t, even on a 32-bit
system, so it's important to use loff_t instead.  This
fixes a corrupted
core dump in the bigcore test in GDB's testsuite.

Signed-off-by: Daniel Jacobowitz
<dan@codesourcery.com>

Index: linux-2.6.11/fs/binfmt_elf.c
===================================================================
--- linux-2.6.11.orig/fs/binfmt_elf.c	2005-06-09
16:38:17.000000000 -0400
+++ linux-2.6.11/fs/binfmt_elf.c	2005-06-10
00:10:52.000000000 -0400
@@ -1125,7 +1125,7 @@ static int dump_write(struct
file *file,
 	return file->f_op->write(file, addr, nr,
&file->f_pos) == nr;
 }
 
-static int dump_seek(struct file *file, off_t off)
+static int dump_seek(struct file *file, loff_t off)
 {
 	if (file->f_op->llseek) {
 		if (file->f_op->llseek(file, off, 0) != off)
-- 




--- Jesper Juhl <jesper.juhl@gmail.com> wrote:

> On 30/11/06, linux err <linux_err@yahoo.com> wrote:
> > Does anyone know what determines the size of a
> core
> > dump? I have a process running out of memory (it
> > allocates about 3GB) - but the size of core varies
> > (between 2-3GB) depending on how much the process
> > wrote on the allocated memory.
> >
> 
> Makes perfect sense. The core dump contains the
> memory of the process,
> so if the process has 3GB in use then the core file
> will be 3GB.
> 
> You can limit the size of core dumps with "ulimit
> -c"
> 
> 
> > Also, the time it takes to write the core (same
> size)
> > varies??
> >
> Could be many reasons for that. If the load on the
> machine varies the
> time to perform any given action will vary as well.
> 
> 
> > I briefly looked at elf_core_dump and
> get_user_pages()
> > in binfmt_elf.c. Is there any documentation on
> this?
> > Or anyone knows how it works?
> >
> http://x86.ddj.com/ftp/manuals/tools/elf.pdf
> http://en.wikipedia.org/wiki/Core_dump
> 
> 
> -- 
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post 
> http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please     
> http://www.expita.com/nomime.html
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



 
____________________________________________________________________________________
Do you Yahoo!?
Everyone is raving about the all-new Yahoo! Mail beta.
http://new.mail.yahoo.com
