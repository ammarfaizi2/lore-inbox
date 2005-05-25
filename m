Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVEYQq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVEYQq2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 12:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVEYQq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 12:46:28 -0400
Received: from fmr18.intel.com ([134.134.136.17]:33244 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261403AbVEYQpx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 12:45:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/4] Kprobes support for IA64
Date: Wed, 25 May 2005 09:46:00 -0700
Message-ID: <032EB457B9DBC540BFB1B7B519C78B0E07376D26@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/4] Kprobes support for IA64
thread-index: AcVhMeiPpvDdMK7iTGKKD4oClebmZwAFGhPw
From: "Lynch, Rusty" <rusty.lynch@intel.com>
To: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Cc: "Keith Owens" <kaos@sgi.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       <akpm@osdl.org>, "Luck, Tony" <tony.luck@intel.com>,
       "Seth, Rohit" <rohit.seth@intel.com>, <prasanna@in.ibm.com>,
       <ananth@in.ibm.com>, <systemtap@sources.redhat.com>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 May 2005 16:45:40.0201 (UTC) FILETIME=[2F2E7D90:01C56149]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan D. Brunelle [mailto:Alan.Brunelle@hp.com]
>Isn't the real issue here that if kprobes attempts to put in a 'break
>0x80200' into a B-slot that it instead becomes a 'break.b 0' -- as the
>break.b does not accept an immediate value? Which probably means that
>either kprobes (a) should not rely on the immediate value of the break
>at all (always put in an immediate value of 0), or (b) kprobes should
>not allow a probe on a B-slot of an instruction bundle.
>
>Kprobes does have the two cases covered in traps.c (case 0 - when a
>B-slot break is used, and case 0x80200 for a non-B-slot break). But
this
>doesn't seem very clean. (If it was decided that one should not
overload
>the break 0 case, and instead use a uniquely defined break number, then
>it fails on a B-slot probe. If it is OK to overload the break 0 case,
>why have another break number at all?)
 
The realization that breaking on a b-slot caused the immediate value to
be ignored happened after we had the main portion of kprobes and jprobes
implemented.  Now that I think about it, there really isn't any reason
to ever use anything but an immediate value of zero for all cases.

Well... except for maybe gaining control back from a jprobe.  The
current patch doesn't take advantage of the fact that a jprobe uses a
different immediate value (as you point out below).  Instead it is up to
pre_kprobe_handler() to recognize the case (see the jprobe comment in
the middle of the function.)  I would rather have
kprobes_exceptions_notify() call a separate jprobe handler function.

The Jprobe break is not inserted in an existing bundle like the break
used to gain initial control for kprobes, to the break0 thing is not an
issue.

>
>I started doing a port of kprobes, ran into this, and decided to try a
>different mechanism that replaced the whole instruction bundle - so
that
>I could format the instruction bundle to allow a break instruction with
>an immediate value (and thus uniquely identify KPROBE breaks).
>[Basically put the break in the 1st slot (all the time), and then go
>execute the original instruction *bundle* elsewhere when the break is
hit.]
>

We explored this for a while, but you start getting lots of
complications when you consider that other probes could be inserted on
the remaining slots of the same bundle.

I think we can have a sensible implementation that always inserts a
break with a zero immediate value, and then have jprobes execute a break
with a reserved non-zero immediate value.

>PS. I don't see the 0x80300 defined __IA64_BREAK_JPROBE being used
>anywhere...

The number is being used in jprobes.S:jprobe_break, but not the #define
for some reason (but it should.)

Although, like I pointed out before, the current handler does not take
advantage of this.

>
>Alan D. Brunelle
>Hewlett-Packard
>
>
>Lynch, Rusty wrote:
>
>>>From: Keith Owens [mailto:kaos@sgi.com]
>>>Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com> wrote:
>>>
>>>
>>>>This patch adds the kdebug die notification mechanism needed by
>>>>
>>>>
>>Kprobes.
>>
>>
>>>>	      case 0: /* unknown error (used by GCC for
>>>>
>>>>
>>__builtin_abort()) */
>>
>>
>>>>+		if (notify_die(DIE_BREAK, "kprobe", regs, break_num,
>>>>
>>>>
>>>TRAP_BRKPT, SIGTRAP)
>>>
>>>
>>>>+			       	== NOTIFY_STOP) {
>>>>+			return;
>>>>+		}
>>>>		die_if_kernel("bugcheck!", regs, break_num);
>>>>		sig = SIGILL; code = ILL_ILLOPC;
>>>>		break;
>>>>
>>>>
>>>Nit pick.  Any break instruction in a B slot will set break_num 0, so
>>>you cannot tell if the break was inserted by kprobe or by another
>>>debugger.  Setting the string to "kprobe" is misleading here, change
it
>>>to "break 0".
>>>
>>>
>>
>>Good catch.  We'll update the informational string.
>>
>>    --rusty
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-ia64"
in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>

