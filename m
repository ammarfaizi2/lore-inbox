Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265839AbTFVTru (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 15:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265837AbTFVTru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 15:47:50 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:14220 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265842AbTFVTrr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 15:47:47 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 22 Jun 2003 13:00:11 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler & interactivity improvements
In-Reply-To: <1056298069.601.18.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.55.0306221238230.15064@bigblue.dev.mcafeelabs.com>
References: <1056298069.601.18.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jun 2003, Felipe Alfaro Solana wrote:

> Hi all,
>
> I must say I'm a little bit disappointed with the interactive feeling of
> latest kernels. From what I have read, it seems the scheduler decides on
> the "interactive" behavior of a process based on its CPU usage and
> sleeping times. I am no kernel expert, so I will assume this is how it
> works, more or less, behind the scenes.
>
> I think that marking a process as "interactive" based on the previous
> premise is quite unreal. Let's take, for example, a real application
> like a word processor which performs background spell checking. The word
> processor should be considered interactive, even when it may be hogging
> the CPU a lot to perform the background spell check and the rest of its
> threads are sleeping waiting for user input.

I'm sorry to disagree. A word processor that waited 24 hours to receive an
input should be *gradually* migrated to lower priorities (CPU hogs) when
it starts eating all its timeslice. You can tune how *gradually* (negative
feedback) you move the process, but you can't bolt in explicit rules into
the scheduler. If your word processor that was waiting by 24 hours will
start eating all its timeslice, it must be migrated down in priority. When
the spell check will be over, it'll re-gain its status of interactive task.
One suggestion for Ingo would be to use the previous task history to
compute how gradually to migrate the task, with a factor for each direction.
Processes with a long history of interactive tasks should have a brake
when migrating towards lower priorities, like the ones that showed CPU
hogs properties repeatedly should have a brake when moving to higher
priorities. The value of this "brake" should be made function of the
previous history.



- Davide

