Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283639AbRK3Mfb>; Fri, 30 Nov 2001 07:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283641AbRK3MfW>; Fri, 30 Nov 2001 07:35:22 -0500
Received: from bugs.unl.edu.ar ([168.96.132.208]:61089 "EHLO bugs.unl.edu.ar")
	by vger.kernel.org with ESMTP id <S283639AbRK3MfH>;
	Fri, 30 Nov 2001 07:35:07 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?Mart=EDn=20Marqu=E9s?= <martin@bugs.unl.edu.ar>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Re: OT: svscan and the hard disk
Date: Fri, 30 Nov 2001 09:33:21 -0300
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011130123323.CED6DFA61@bugs.unl.edu.ar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any thoughts on what DJB thinks of the Linux FS?

Sorry for him, each day I convince myself of not using Qmail ever!

Saludos... :-)

----------  Forwarded Message  ----------

Subject: Re: OT: svscan and the hard disk
Date: 30 Nov 2001 02:05:35 -0000
From: "D. J. Bernstein" <djb@cr.yp.to>
To: qmail@list.cr.yp.to

Pavel Kankovsky writes:
> all my attempts to find any piece of standard/specification/documentation
> saying that fs metadata are to be updated synchronously have failed so far

doc/smm/03.fsck_ffs/2.t

The guarantees provided by FFS make it reasonably easy for mail-handling
software to perform reliable disk transactions. The speed is adequate
for most sites.

The Linux filesystem designers, ignorant of the demands of critical
applications, screwed this up in two ways:

   * They broke compatibility, by failing to provide the FFS system
     calls with the FFS guarantees.

     They wanted an asynchronous rename(), for example. They should have
     added an asyncrename() system call. Instead they foolishly changed
     the semantics of rename(), breaking mail-handling programs.

     Of course, the incompatibility isn't obvious to people who don't
     realize that some programs rely on rename() being synchronous.

   * They didn't provide any way to perform reliable transactions, other
     than syncing the whole filesystem (with, e.g., a directory fsync).

     Even sync mode is worrisome. Has anyone verified that blocks are
     written to disk in the correct order? This is not rocket science,
     but it does require a certain level of care with every operation.

     Supposedly there's a faster transaction mechanism now, but I don't
     trust it. Do the people writing the filesystem code understand that
     there _is_ a correct order for block writes?

The situation since then has become even worse. Filesystem reliability
has gone down the tubes: users are regularly suffering data corruption,
even when there _isn't_ a crash. There are at least four different
filesystem transaction interfaces.

I'm reorganizing most of my create-one-file programs to use a generic
atomicwrite tool, so that all the stupid portability issues are isolated
inside one program. Meanwhile, qmail 2 uses its own internal filesystem
for the queue.

---Dan
n

-------------------------------------------------------

-- 
Porqué usar una base de datos relacional cualquiera,
si podés usar PostgreSQL?
-----------------------------------------------------------------
Martín Marqués                  |        mmarques@unl.edu.ar
Programador, Administrador, DBA |       Centro de Telematica
                       Universidad Nacional
                            del Litoral
-----------------------------------------------------------------
