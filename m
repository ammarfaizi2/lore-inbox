Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUENObZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUENObZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 10:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUENO30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 10:29:26 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:37018 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261252AbUENOQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 10:16:02 -0400
Message-ID: <40A4D49C.3030300@myrealbox.com>
Date: Fri, 14 May 2004 07:15:56 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
CC: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities, take 3 (Re: [PATCH] capabilites, take 2)
References: <200405131308.40477.luto@myrealbox.com>	<20040513182010.L21045@build.pdx.osdl.net>	<200405131945.53723.luto@myrealbox.com> <87d657z2lm.fsf@goat.bogus.local>
In-Reply-To: <87d657z2lm.fsf@goat.bogus.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche wrote:

> Andy Lutomirski <luto@myrealbox.com> writes:
> 
> 
>>+	/* Pretend we have VFS capabilities */
>>+	cap_set_full(bprm->cap_inheritable);
>>+	if ((bprm->secflags & BINPRM_SEC_SETUID) && bprm->e_uid == 0)
>>+		cap_set_full(bprm->cap_permitted);
>>+	else
>>+		cap_clear(bprm->cap_permitted);
> 
> 
> I'd move this to security/commoncap.c:

[snip]

I put it in fs/exec.c because I had to add it to binprm anyway
(having commoncap use ->security would break SELinux), and, as
long as it's a permanent member of the structure, it made sense
for it to always be filled in.

>>+	/* FIXME: Is this overly harsh on setgid? */
>>+	if ((bprm->secflags & (BINPRM_SEC_SETUID | BINPRM_SEC_SETGID)) &&
>>+	    new_pI != CAP_FULL_SET)
>>+			bprm->secflags |= BINPRM_SEC_NOELEVATE;
>>+
>>+	if (bprm->secflags & BINPRM_SEC_NOELEVATE) {
>>+		is_setuid = is_setgid = 0;
>>+		cap_clear(fP);
>>+	}
> 
> 
> This prevents sendmail from being setuid mail and
> cap_net_bind_service=ep.

AAAAH!  That's right -- in my implementation <some cap>=ep on a file
makes no sense.  It's got to be inheritable to be permitted.

On the other hand, that rule could be safely by checking the old pI
as opposed to the new one.  The idea is to prevent a process without
full pI from execing (and thus confusing) old setuid apps.


BTW, in your capabilities implementation, why do you do:

# chcap cap_net_bind_service=ei /usr/sbin/named
# inhcaps cap_net_bind_service=i bind:bind /usr/sbin/named

It seems to me that this wants to be:

# inhcaps cap_net_bind_service=eip bind:bind /usr/sbin/named
(not having looked at your user tool)
or
# cap -c cap_net_bind_service=eip -u bind -g bind /usr/sbin/named
(using my tool)

With my patch, that just works (no fs caps necessary).  Why should the
admin have to tag a program so it is allowed to inherit caps?  (If
named used libexec, then its libexec helpers would have to be similarly
tagged, and, if it used bash, then bash would need the inheritable tag.)

If the answer's because that's how Linux cap evolution works, then
I'd say that Linux cap evolution is broken.

In any case, I'll probably redo my patch to restore the IRIX version of pI.

--Andy



> 
> Regards, Olaf.

