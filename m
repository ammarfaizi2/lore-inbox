Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVJQMKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVJQMKp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 08:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVJQMKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 08:10:44 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:147 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S932288AbVJQMKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 08:10:44 -0400
Message-ID: <435394A1.7000109@cosmosbay.com>
Date: Mon, 17 Oct 2005 14:10:09 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Jean Delvare <khali@linux-fr.org>, torvalds@osdl.org,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: [RCU problem] was VFS: file-max limit 50044 reached
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com>
In-Reply-To: <20051017103244.GB6257@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------060609030408040007060107"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 17 Oct 2005 14:10:10 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060609030408040007060107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Dipankar Sarma a écrit :
> On Mon, Oct 17, 2005 at 11:10:04AM +0200, Eric Dumazet wrote:
>>
>>Fixing the 'file count' wont fix the real problem : Batch freeing is good 
>>but should be limited so that not more than *billions* of file struct are 
>>queued for deletion.
> 
> 
> Agreed. It is not designed to work that way, so there must be
> a bug somewhere and I am trying to track it down. It could very well
> be that at maxbatch=10 we are just queueing at a rate far too high
> compared to processing.
> 

I can freeze my test machine with a program that 'only' use dentries, no files.

No message, no panic, but machine becomes totally unresponsive after few seconds.

Just greping for call_rcu in kernel sources gave me another call_rcu() use 
from syscalls. And yes 2.6.13 has the same problem.

Here is the killer on by HT Xeon machine (2GB ram)

Eric


--------------060609030408040007060107
Content-Type: text/plain;
 name="stress2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stress2.c"

#include <unistd.h>
#include <sys/types.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/stat.h>

int main(void)
{
	int i, rc;	
	struct stat st;
	char name[1024];

	memset(name, 'a', sizeof(name));

	for (i = 0; i < 1000000000;i++) {
		sprintf(name + 220, "%d", i);
		rc = stat(name, &st);
		if (rc == -1 && errno != ENOENT) {
			perror(name);
		}
	}
	return 0;
}

--------------060609030408040007060107--
