Return-Path: <linux-kernel-owner+w=401wt.eu-S932787AbXASAmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbXASAmV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 19:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932801AbXASAmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 19:42:21 -0500
Received: from mail9.hitachi.co.jp ([133.145.228.44]:45673 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932787AbXASAmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 19:42:20 -0500
Message-ID: <45B01387.7010207@hitachi.com>
Date: Fri, 19 Jan 2007 09:40:39 +0900
From: "Kawai, Hidehiro" <hidehiro.kawai.ez@hitachi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4) 
    Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, james.bottomley@steeleye.com,
       Satoshi OSHIMA <soshima@redhat.com>,
       "Hideo AOKI@redhat" <haoki@redhat.com>,
       sugita <yumiko.sugita.yf@hitachi.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] binfmt_elf: core dump masking support
References: <457FA840.5000107@hitachi.com> 
    <20061213132358.ddcaaaf4.akpm@osdl.org> <20061220154056.GA4261@ucw.cz> 
    <45A2EADF.3030807@hitachi.com> <20070109143912.GC19787@elf.ucw.cz> 
    <45A74B89.4040100@hitachi.com> <20070114200157.GA2582@elf.ucw.cz>
In-Reply-To: <20070114200157.GA2582@elf.ucw.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,
 
>>>Well, you can have it as set of 0-1 "limits"...
>>
>>I have come up with a similar idea of regarding the ulimit
>>value as a bitmask, and I think it may work.
>>But it will be confusable for users to add the new concept of
>>0-1 limitation into the traditional resouce limitation feature.
>>Additionaly, this approach needs a modification of each shell
>>command.
>>What do you think about these demerits?
> 
>>The /proc/<pid>/ approach doesn't have these demerits, and it
>>has an advantage that users can change the bitmask of any process
>>at anytime.
> 
> Well... not sure if it is advantage. 

For example, consider the following case:
  a process forks many children and system administrator wants to
  allow only one of these processes to dump shared memory.

This is accomplished as follows:

 $ echo 1 > /proc/self/coremask
 $ ./some_program
 (fork children)
 $ echo 0 > /proc/<a child's pid>/coremask

With the /proc/<pid>/ interface, we don't need to modify the
user program.  In contrast, with the ulimit or setrlimit interface,
the administrator can't do it without modifying the user program
to call setrlimit.  This will not be preferred.


> Semantics of ulimit inheritance
> are well given, for example. How is this going to be inherited?

The coremask setting is inherited in mm_init(), which is called
once as an extention of do_fork(), do_execve() or compat_do_execve().
Inheritance is done by copying the bitmask from current->mm->coremask.
However, if current->mm is NULL, the inherited bitmask is set to 0
(default value).

Best regards,
-- 
Hidehiro Kawai
Hitachi, Ltd., Systems Development Laboratory


