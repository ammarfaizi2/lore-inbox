Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWJLTZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWJLTZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 15:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWJLTZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 15:25:59 -0400
Received: from mail.corp.idt.net ([169.132.25.53]:22288 "EHLO
	mail.corp.idt.net") by vger.kernel.org with ESMTP id S1750735AbWJLTZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 15:25:58 -0400
Message-ID: <452E96C5.8070307@hq.idt.net>
Date: Thu, 12 Oct 2006 15:25:57 -0400
From: Serge Aleynikov <serge@hq.idt.net>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Alan Cox <alan@redhat.com>
Subject: Re: non-critical security bug fix
References: <452D3ED9.509@hq.idt.net> <20061012190647.GA6725@sergelap.austin.ibm.com>
In-Reply-To: <20061012190647.GA6725@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge (what a nice name!  ;-) ),

Let me give you an example where we found this patch very useful.

A 3rd party library that we bought implemented a user-level SCTP 
protocol by opening raw sockets.  This required our application to run 
as root.  However, we didn't want for it to run as root, and wanted to 
set the CAP_NET_RAW option and have the interaction with the raw socket 
survive after when we switch the effective user away from root.

When reading "man capabilities" we found:

"If  a  process  that has a 0 value for one or more of its user IDs 
wants to prevent its permitted capability set being cleared when it 
resets all of its user IDs to non-zero values, it can  do  so  using 
the  prctl() PR_SET_KEEPCAPS operation."

Correct me if I am wrong, but I believe that this sentence says just 
what I described above.  If so, the previously attached patch has the 
behavior described in the man page.

Regards,

-- 
Serge Aleynikov
Routing R&D, IDT Telecom
Tel: +1 (973) 438-3436
Fax: +1 (973) 438-1464


Serge E. Hallyn wrote:
> Quoting Serge Aleynikov (serge@hq.idt.net):
>> To Maintainers of the linux/security/commoncap.c:
>>
>> Patch description:
>> ==================
>> This bug-fix ensures that if a process with root access sets 
>> keep_capabilities flag, current capabilities get preserved when the 
>> process switches from root to another effective user.  It looks like 
>> this was intended from the way capabilities are documented, but the 
>> current->keep_capabilities flag is not being checked.
> 
> Note that without your patch, the permitted set is maintained, so that
> you can regain the caps into your effective set after setuid if you
> need.  i.e.
> 
> 	prctl(PR_SET_KEEPCAPS, 1);
> 	setresuid(1000, 1000, 1000);
> 	caps = cap_from_text("cap_net_admin,cap_sys_admin,cap_dac_override=ep");
> 	ret = cap_set_proc(caps);
> 
> So this patch will change the default behavior, but does not add
> features or change what is possible.
> 
> Ordinarely I'd say changing default behavior wrt security is a bad
> thing, but given that this is "default behavior when doing prctl(PR_SET_KEEPCAPS)",
> I don't know how much it matters.
> 
> Still, I like the current behavior, where setuid means drop effective
> caps no matter what.
> 
> -serge
> 



