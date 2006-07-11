Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWGKT1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWGKT1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWGKT1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:27:14 -0400
Received: from 242.178.36.72.reverse.layeredtech.com ([72.36.178.242]:49876
	"EHLO tapestrysystems.com") by vger.kernel.org with ESMTP
	id S1750829AbWGKT1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:27:13 -0400
Message-ID: <44B3FB90.6050106@madrabbit.org>
Date: Tue, 11 Jul 2006 12:27:12 -0700
From: Ray Lee <ray-lk@madrabbit.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, "Bill Ryder" <bryder@wetafx.co.nz>
Subject: Re: [PATCH 2.6.18-rc1] Make group sorting optional in the 2.6.x kernels
References: <44B32888.6050406@wetafx.co.nz> <2c0942db0607111120h686e70x44037730a1a4c92f@mail.gmail.com>
In-Reply-To: <2c0942db0607111120h686e70x44037730a1a4c92f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry for the duplicate, Bill -- lkml bounced my gmail account's message.)

In addition to Randy's fine comments...

On 7/10/06, Bill Ryder <bryder@wetafx.co.nz> wrote:
> Like many places Weta Digital (we did the VFX for Lord of the Rings,
> King Kong etc) uses supplemental group lists to allow users access to
> multiple directories and files (films mostly in our case) .
> Unfortunately NFSv2 and NFSv3 AUTH_UNIX flavour authentication is
> hardcoded to only support 16 supplemental groups. Since we currently
> have some users and processes which need to be in more than 16 groups
> we use setgroups to build a list of groups that a process requires
> when they access data on nfs exported filesystems.
>
> This worked fine for the 2.4.x kernels. 2.6.x is designed to handle
> thousands of groups for a single user. To support that the kernel was
> changed to sort the group list, then use a binary search to decide if
> a user was in the correct group. Unfortunately this BREAKS the use of
> setgroups(2) to put the 16 most important groups first.
>
> This patch provides the option of not sorting that list. The help
> describes the pitfalls of not sorting the groups (performance when
> there are a lot of groups).

It seems there's a third way to do this that would maintain setgroups(2)
compatibility and speed when you have a lot of groups.

Maintain the list of groups such that the first sixteen correspond to
what setgroups(2) requested, and keep the rest sorted. A search for
groups would then linearly check each of the first sixteen entries then,
if there's more, binary search the remainder from 16 to group_info->ngroups.

That'd allow this to be enabled everywhere (removing the CONFIG_
option), maintain backward compatibility, and still be fast in the face
of thousands of groups. The down side is slightly more complex code.
Well, and that you have to write it :-/.

On the other hand, as I haven't looked at the groups code, my suggestion
may be, y'know, nuts.

Ray
