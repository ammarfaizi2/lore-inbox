Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129329AbRBPAEv>; Thu, 15 Feb 2001 19:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129566AbRBPAEh>; Thu, 15 Feb 2001 19:04:37 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:6667 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129253AbRBPAE0>; Thu, 15 Feb 2001 19:04:26 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>
Date: Fri, 16 Feb 2001 11:04:11 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14988.28283.763030.311896@notabene.cse.unsw.edu.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Andrew Morton'" <andrewm@uow.edu.au>
Subject: RE: NFSD die with 2.4.1 (resend with ksymoops)
In-Reply-To: message from Jean-Eric Cuendet on Thursday February 15
In-Reply-To: <B45465FD9C23D21193E90000F8D0F3DF683961@mailsrv.linkvest.ch>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday February 15, Jean-Eric.Cuendet@linkvest.com wrote:
> 
> Here I am again! NFSD died at 11h23, ~12 hours after the last reboot, a
> record :-)

I'm guessing you don't have many symlinks on the exported
filesystem....

> I'll try to best answer your questions.
> 
> > This trace seems to make sense, except that nfssvc_encode_diropres
> > doesn't seem to make any subroutine calls at offset 100 as seems to be
> > implied. 
> > 
> > Could you run
> > 
> >  echo disassemble nfssvc_encode_diropres | gdb -batch -x 
> > /dev/stdin vmlinux
> 
> It's in the attached file.
> In fact, the Oops was with a new compiled kernel with NFSD in modules... So
> the GDB stuff would not work...
> So attached is the output of GDB recompiled with NFSD in the kernel. Is it
> sufficient for you? It's not the one that was running but just recompiled.
> If not, I'll send you a new Oops + GDB output of a RUNNING kernel with NFSD
> in the kernel.
> 
> > giving it the vmlinux that was running when this oops was 
> > produced? and
> > also tell me exactly what patches you have ontop of 2.4.1 and where to
> > find them.
> 
> I have only ACL patched. You can find them at acl.bestbits.at.

The information you sent was very helpful.
You are getting an Oops here:
> 0xc0173769 <nfssvc_encode_diropres+89>:	push   $0x8000
> 0xc017376e <nfssvc_encode_diropres+94>:	push   %ecx
> 0xc017376f <nfssvc_encode_diropres+95>:	mov    0x48(%eax),%eax
> 0xc0173772 <nfssvc_encode_diropres+98>:	call   *%eax
                                                ^^^^^^^^
%eax is zero.
This corresponds to the code fragment:
+	if (IS_POSIX_ACL(inode) && inode->i_op) {
+		posix_acl_t *acl = inode->i_op->get_posix_acl(
+			inode, ACL_TYPE_ACCESS);

%eax has the value of inode->i_op->get_posix_acl.  Clearly this field
hasn't been initialised.
A quick look at the patch suggests that it doesn't get initialised for
symlinks, but I haven't poured over it in detail.

I must admit that it appears somewhat courageous to be running 2.4.1
with patches that were made for 2.4.0-test12 on a production machine,
but I guess you know what you are doing.

> I have tried without them, with exactly the same behaviour.
> 

That may be, but you have only given evidence that it that there are
problems with the patches installed, and that evidence points very
strongly at a problem with the patch.  If you can give me evidence (an
Oops for example) which shows problems without the patches, then I
will be happy to look at it.

Also, the most recent ksymoops output is totally useless.  It looks
like the kernel image that ksymoops was using to find symbol
information was different from the kernel image that was running.
It is very important that these two match, or the result is of no use.

NeilBrown
