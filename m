Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317653AbSHHQu4>; Thu, 8 Aug 2002 12:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317661AbSHHQuz>; Thu, 8 Aug 2002 12:50:55 -0400
Received: from mons.uio.no ([129.240.130.14]:63957 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317653AbSHHQuy>;
	Thu, 8 Aug 2002 12:50:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15698.41542.250846.334946@charged.uio.no>
Date: Thu, 8 Aug 2002 18:54:30 +0200
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.30+] Second attempt at a shared credentials patch
In-Reply-To: <44050000.1028823650@baldur.austin.ibm.com>
References: <23130000.1028818693@baldur.austin.ibm.com>
	<shsofcdfjt6.fsf@charged.uio.no>
	<44050000.1028823650@baldur.austin.ibm.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave McCracken <dmccr@us.ibm.com> writes:

    >> Instead of doing this as one big unreadable monolithic patch
    >> and risking getting things wrong like in the above case, it
    >> would be nice if you could go via a set of wrapper functions:
    >>
    >> # define get_current_uid() (current->uid) define
    >> # set_current_uid(a) current->uid = a

     > I don't see this as a win.  I *could* do a big monolithic patch
     > to change all references to current->*id to macros, then change
     > the macros in a separate patch.  But then we'd be stuck with
     > macros for all those references forever, and they're not likely
     > to change again any time soon.  I don't think we'd really want
     > to have macros for all our structure references on the off
     > chance that someone might change it in the future.

Why? Macros (and inlined functions) have the advantage that they
enforce good policy. Doing 'task->cred->uid = a' on tasks other than
'current' is in general not a very safe thing to do. This sort of
issue w.r.t. safe policies should in particular be worrying you when
you start adding CRED_CLONE...
There are good precedents for this sort of argument: see
'set_current_state()' & friends.

In addition, those macros would allow you to set up compatibility with
2.4.x and simplify patch backports.


As for changing the structure: As I said previously I'd like to unify
all those { fsuid, fsgid, group } things into a proper ucred, so that
we can share these objects around the VFS, and cache them...
Your 'struct cred' as it stands will not suffice to do all that since
it does not provide the necessary Copy On Write protection. (For
instance if some thread temporarily raises my process privileges, I
will *not* want all my already opened 'struct file's to suddenly gain
root access).

Cheers,
  Trond
