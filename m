Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423023AbWBAX1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423023AbWBAX1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 18:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423024AbWBAX1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 18:27:19 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:64196 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1423023AbWBAX1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 18:27:18 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: "Sam Ravnborg" <sam@ravnborg.org>
cc: "Dave Hansen" <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] kbuild: drop vmlinux dependency from 'make install' 
In-reply-to: Your message of "Tue, 31 Jan 2006 22:04:19 BST."
             <29639.194.237.142.10.1138741459.squirrel@194.237.142.10> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 02 Feb 2006 10:27:14 +1100
Message-ID: <20325.1138836434@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sam Ravnborg" (on Tue, 31 Jan 2006 22:04:19 +0100 (CET)) wrote:
>> On Mon, 2006-01-09 at 22:38 +0100, Sam Ravnborg wrote:
>>> This removes the dependency from vmlinux to install, thus avoiding the
>>> current situation where "make install" has a nasty tendency to leave
>>> root-turds in the working directory.
>>
>> One minor issue I've noticed with this is that I have script that do:
>>
>> 	make -j8 vmlinux install
>>
>> Without the dependency, I think the install is done in parallel, and
>> doesn't get the result of that build.
>Correct. All targets on the commandline are evaluated in parallel.
>
>>  Is there a way I can accomplish
>> the same thing with one make command with the new dependency?
>No - unfortunately not.
>
>Oh, you may restrict yourself to UP and use make -j1 but that would be
>a workaround ;-)

Pseudo code: make install, modules-install etc. depend on other targets
if and only if there are multiple targets on the command line.  A bare
make install will have no dependencies on vmlinux, make install plus
other targets will wait for the other targets.  Mind you, I still think
that removing the dependency to avoid root turds is the wrong approach.

goal := $(sort $(MAKECMDGOALS))
goal_install := $(filter %install,$(goal))
goal_other := $(filter-out %install,$(goal))
ifneq ($(goal_install),)
  ifneq ($(goal_other),)
    $(goal_install): $(goal_other)
  endif
endif

