Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSHITsS>; Fri, 9 Aug 2002 15:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSHITsS>; Fri, 9 Aug 2002 15:48:18 -0400
Received: from pat.uio.no ([129.240.130.16]:40647 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S315536AbSHITsR>;
	Fri, 9 Aug 2002 15:48:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15700.7516.306330.976815@charged.uio.no>
Date: Fri, 9 Aug 2002 21:51:56 +0200
To: Dave McCracken <dmccr@us.ibm.com>
Cc: trond.myklebust@fys.uio.no, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.30+] Fourth attempt at a shared credentials patch
In-Reply-To: <55560000.1028921049@baldur.austin.ibm.com>
References: <23130000.1028818693@baldur.austin.ibm.com>
	<shsofcdfjt6.fsf@charged.uio.no>
	<44050000.1028823650@baldur.austin.ibm.com>
	<15698.41542.250846.334946@charged.uio.no>
	<52960000.1028829902@baldur.austin.ibm.com>
	<15698.52455.437254.428402@charged.uio.no>
	<81390000.1028837464@baldur.austin.ibm.com>
	<15698.59577.788998.300262@charged.uio.no>
	<55560000.1028921049@baldur.austin.ibm.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave McCracken <dmccr@us.ibm.com> writes:

     > --On Thursday, August 08, 2002 11:55:05 PM +0200 Trond
     > Myklebust <trond.myklebust@fys.uio.no> wrote:

    >> What if one thread is doing an RPC call while the other is
    >> changing the 'groups' entry?

     > Gah.  Good point.  Ok, I've added locking to the cred structure
     > to handle this.  Here's my new patch with those changes made:

     > http://www.ibm.com/linux/ltc/patches/misc/cred-2.5.30-5.diff.gz

     > I've gone through all the code again, and don't see any other
     > places where locking is really necessary.  Feel free to point
     > them out to me if you see any.

Err... Well my original point about your changes to the sunrpc code
still stand: no spinlocking there AFAICS. In addition, you'll want to
talk to the Intermezzo people: they do allocation of buffers based on
the (volatile) value of cred->ngroups.

Finally, you also want all those reads and changes to more than one
value in the credential such as the stuff in security/capability.c, or
net/socket.c,... to be atomic. (Note: This is where 'struct ucred'
with COW gives you an efficiency gain).

Please also note that you only need spinlocking for the particular
case of tasks that have set CLONE_CRED. In all other cases, it adds a
rather nasty overhead...

Cheers,
  Trond
