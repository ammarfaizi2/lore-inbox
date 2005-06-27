Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVF0G1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVF0G1G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 02:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVF0G0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 02:26:03 -0400
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:37639 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261861AbVF0GZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 02:25:03 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.93,232,1114984800"; 
   d="scan'208"; a="10059028:sNHT28058900"
Message-ID: <42BF9BB8.4050406@fujitsu-siemens.com>
Date: Mon, 27 Jun 2005 08:24:56 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 initrd module loading seems parallel on bootup
References: <4jtOU-508-21@gated-at.bofh.it> <4jz7U-9S-7@gated-at.bofh.it> <4jBCN-20Q-9@gated-at.bofh.it>
In-Reply-To: <4jBCN-20Q-9@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsár Balázs wrote:

>>I'd like to know what changed in the kernel to make nash's behaviour
>>change.  Martin, did you work that out?
> 
> 
> See http://lkml.org/lkml/2005/1/17/132

I am not sure if it was the culprit. The problem was that nash is
running as init() with PID 1 and therefore all processes are its child
processes. Thus a fairly normal code such as

if (fork())
	wait4(-1...)

that would work under normal circumstances (there are no other real
children) can fail here. The terminating "children" that were
interfering here were all udev processes as far as I observed. I suppose
that inserting a module triggers udev which spawns a process which may
under certain circumstances terminate earlier than the insmod itself.

nash could also have solved the problem simply by fork()ing itself once
before doing any real work, so that it wouldn't run with pid 1.

Regards
Martin

