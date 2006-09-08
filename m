Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWIHRRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWIHRRK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 13:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWIHRRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 13:17:10 -0400
Received: from smtp-out.google.com ([216.239.45.12]:25085 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750806AbWIHRRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 13:17:09 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=PyWgyJLiz1bz/GcX1EQSix7Wq1aCqnkZ0qzKSMlnwu7LJ8BK7j8Pmvfsy9kA3VcPr
	c9jGS989RTImOqtok6uGA==
Message-ID: <4501A583.2050500@google.com>
Date: Fri, 08 Sep 2006 10:16:51 -0700
From: Edward Falk <efalk@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Proper /proc/pid/cmdline behavior when command line is corrupt?
References: <mailman.3.1157626801.14788.linux-kernel-daily-digest@lists.us.dell.com> <4500D1E6.7020805@google.com> <Pine.LNX.4.61.0609080919130.22545@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0609080919130.22545@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> Hi Edward,

>>that the environment buffer is assumed to immediately follow the
>>command line buffer.
> 
> 
> The environment buffer is not assumed to be there, it is _known_ to come right
> after the argument string, because that is how the kernel sets it up on execve
> (for x86 at least).

Is that in a spec somewhere?  Otherwise, I would argue that it isn't 
_known_ to come right after the argument string, it just _happens_ to 
come right after the argument string.  This could change in future kernels.



>>I'm currently working on a patch that removes the one page limit on
>>the returned command line buffer but I'm not convinced I should
>>retain this behavior.
> 
> 
> I think yes. proc_pid_cmdline() has these lines:
> 
> 	len = mm->arg_end - mm->arg_start
>   *	if (len > PAGE_SIZE)
>   *		len = PAGE_SIZE;
> 	res = access_process_vm(task, mm->arg_start, buffer, len, 0);
> 
> 
> and @buffer is allocated in the caller as only one page:

True, but that's an arbitrary limitation which I'm in the process of 
removing.  I have a new version of proc_pid_cmdline() which will return 
the entire commandline buffer no matter what its length.  If the 
grab-more-data-from-environment-buffer behavior is actually broken, I'd 
rather not propagate it to the new code.

	-ed falk
