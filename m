Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264357AbUEYAY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbUEYAY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 20:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264360AbUEYAY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 20:24:27 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:45283 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264357AbUEYAYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 20:24:03 -0400
Message-ID: <40B2921A.1010208@myrealbox.com>
Date: Mon, 24 May 2004 17:23:54 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Stephen Smalley <sds@epoch.ncsc.mil>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       olaf+list.linux-kernel@olafdietsche.de
Subject: Re: [PATCH] caps, compromise version (was Re: [PATCH] scaled-back
 caps, take 4)
References: <fa.dt4cg55.jnqvr5@ifi.uio.no> <40AABE49.1050401@myrealbox.com> <20040519003013.L21045@build.pdx.osdl.net> <200405241638.07296.luto@myrealbox.com> <20040524165630.H21045@build.pdx.osdl.net>
In-Reply-To: <20040524165630.H21045@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

> * Andy Lutomirski (luto@myrealbox.com) wrote:
> 
>>>Hehe, arm wrestling could be entertaining ;-)  I'm in favor of the most
>>>conservative change, which I feel is in my patch.  But I'm game to
>>>continue to pick on each.
>>
>>
>>I like your legacy mode.  I don't like making processes inherit
>>non-legacyness.  (With your patch, some daemon might be secure
>>when started from initscripts but insecure when started from the
>>command line, if root ended up in non-legacy mode.)
> 
> 
> Hmm, that was intentional (my very first cut at this thing cleared it,
> but that patch had many other broken behaviours).  Specifically because
> it goes through pI, which POSIX draft says is untouched through exec.

Not in IRIX, though.  And I'm afraid of:

cap -c all-i <some setuid binary>
versus
cap -c all+i <some setuid binary>

Suddently the binary's behavior might be different.  This isn't 
inheritantly bad, but it seems like a pointless gotcha.

I like my version of using inheritable for legaciness, but only because my 
inheritable semantics make sense.  Your version would worry me a lot less 
if you just added a new field.  But mine doesn't actually need the new field ;)

>>
>>"Legacy mode" is controlled by a new bit in task_struct called
>>keep_all_caps (controlled by PRCTL_SET_KEEPALLCAPS).  This bit turns
>>off setuid emulation completely (except for setfsuid).
> 
> 
> I had same idea.  I wished we could hijack keep_capabilities as a
> bit vector.

It's a bitfield.  Just add fields -- no cost in memory.  Fairly large cost 
in compile time, though...

> 
> 
>>The evolution rules are:
>>pP' = (fP & X) | (pI & pP) [with the setuid-nonroot fix]
>>pE' = (pE | fP) & pP'
>>pI' = full
>>
>>This time around, I haven't touched the unsafeness rules.
>>
>>The magic is in the setuid emulation:
>>	if (current->uid == 0 || current->euid == 0)
>>		cap_set_full(current->cap_inheritable);
>>	else
>>		cap_clear(current->cap_inheritable);
>>
>>So, unless a program plays with it's inheritable mask,
>>root will not pick up caps on exec (which is good -- it
>>means it's safe to chroot somewhere, disable all caps
>>except CAP_SETUID, and let untrusted code play around.)
>>But, if you start as root and setuid away, _even with
>>keepcaps_, you lose the caps on exec.  Which is the broken
>>behavior we want to preserve.
>>
>>So, to avoid this, new code can either set keep_all_caps
>>or just explicitly enable inheritance after setuid, in
>>which case it just works.
>>
>>I have pI' = full because otherwise it's just one more
>>(partially) user-controlled variable that programs need
>>to worry about.  (And because anything else would break
>>root.)
> 
> 
> How do you keep passing down the same caps through multiple execs?

This only takes effect when set*uid is called successfully.  It bites 
programs that start as non-root with CAP_SETUID and change their uid, but 
these programs either don't exist or don't work at all right now.

[root@luto andy]# cap -c all+i -u andy bash
[andy@luto andy]$ dumpcap [note second exec]
         Real        Eff
User    500         500
Group   500         500

Caps: =ip cap_setpcap-p

> 
> 
>>As for the rest of the changes:
>>
>>The code no longer assumes that pI<pP, so I yanked all checks
>>on the inheritable mask.  On the other hand, it makes no
>>sense to me for capset when changing lots of processes'
>>masks to affect the inheritable mask.  So I made it leave
>>it alone, except when changing current.
>>
>>keep_all_caps is clearly not entirely necessary.  I can take
>>it out if anyone objects.
>>
>>I yanked all capset sanity checks from kernel/capability.c --
>>they were duplicates anyway.
>>
>>And I left the old (IMHO pointless) behavior that one needs to hack
>>init in order to use CAP_SETPCAP.
>>
>>[Side note: for cap_bset to be useful, I think there needs to be
>>an operation "atomically remove these caps from all tasks."  I
>>don't see one.]
> 
> 
> Yeah.  It depends on the definition of useful.  Get a couple privileged
> tasks running (which may fork/exec from time to time), then clamp down
> the machine is one form of useful.  In general, I don't cap_bset is that
> useful though.

Especially with CAP_SYS_ADMIN...  SELinux is clearly the way to go here.

I just discovered a patch 
(http://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4-fcap/README) 
that claims to implement per-process-tree maximum cap masks (like I did for 
  awhile).  It hasn't been maintained, though.

If one of our patches hits -mm or -linus, I may try and add a feature like 
that.  It'll (rightly) annoy the SELinux folks, though.

> 
> 
>>This patch also should work fine if VFS capabilities are
>>introduced (there's an fP mask which defaults to (setuid-
>>root ? full : 0).
>>
>>Patch against 2.6.6-mm4 (-mm5 didn't like my filesystem...).
>>It's not as well tested as it should be.  The old cap.cc
>>tool still works (but remember to set inheritable).  I
>>don't have a tool yet to play with keep_all_caps.
> 
> 
> I can add this to the test stuff to play with it.

Except that I fail a lot of your tests because of inheritable mask 
differences.  Oh, well.

I may revive my ext3 caps patch sometime.  Is there a way to make that work 
with your patch?

--Andy
