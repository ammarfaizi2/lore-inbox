Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVCPEVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVCPEVo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 23:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVCPEVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 23:21:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:34750 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262507AbVCPEVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 23:21:19 -0500
Message-ID: <4237B413.8070501@osdl.org>
Date: Tue, 15 Mar 2005 20:20:35 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Taking strlen of buffers copied from userspace
References: <3Iphf-66y-15@gated-at.bofh.it> <4237763A.6080601@shaw.ca>
In-Reply-To: <4237763A.6080601@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Artem Frolov wrote:
> 
>> Hello,
>>
>> I am in the process of testing static defect analyzer on a Linux
>> kernel source code (see disclosure below).
>>
>> I found some potential array bounds violations. The pattern is as
>> follows: bytes are copied from the user space and then buffer is
>> accessed on index strlen(buf)-1. This is a defect if user data start
>> from 0. So the question is: can we make any assumptions what data may
>> be received from the user or it could be arbitrary?
> 
> 
> In general I don't think any such assumptions should be made. In the 
> case of the two below I'm assuming that root access is required to write 
> those files, preventing any serious security hole, but it shouldn't 
> really be permitted to corrupt kernel memory like this, as would likely 
> happen if somebody wrote some data that contained a null as the first 
> character.
> 
>>
>> For example, in ./drivers/block/cciss.c, function cciss_proc_write
>> (line numbers are taken form 2.6.11.3):
>>    ....
>>    293          if (count > sizeof(cmd)-1) return -EINVAL;
>>    294          if (copy_from_user(cmd, buffer, count)) return -EFAULT;
>>    295          cmd[count] = '\0';
>>    296          len = strlen(cmd);      // above 3 lines ensure safety
>>    297          if (cmd[len-1] == '\n')
>>    298                  cmd[--len] = '\0';
>>    .....
>>
>> Another example is arch/i386/kernel/cpu/mtrr/if.c, function mtrr_write:
>>    ....
>>    107          if (copy_from_user(line, buf, len - 1))
>>    108                  return -EFAULT;
>>    109          ptr = line + strlen(line) - 1;
>>    110          if (*ptr == '\n')
>>    111                  *ptr = '\0';
>>     ....
>>
> 
> This one is also unsafe if somebody writes some data which is not 
> null-terminated (assuming that that's possible), since strlen will run 
> off the end of the buffer. The first example doesn't have that problem.

The latter one does (before the listed code):

	memset(line, 0, LINE_SIZE);
	if (len > LINE_SIZE)
		len = LINE_SIZE;
	if (copy_from_user(line, buf, len - 1))
		return -EFAULT;

so isn't line[LINE_SIZE - 1] always 0 ?

-- 
~Randy
