Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269623AbTHAAB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 20:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270605AbTHAAB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 20:01:26 -0400
Received: from users.ccur.com ([208.248.32.211]:24502 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S269623AbTHAABY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 20:01:24 -0400
Date: Thu, 31 Jul 2003 20:01:14 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, rml@tech9.net
Subject: Re: [PATCH] protect migration/%d etc from sched_setaffinity
Message-ID: <20030801000113.GF7852@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20030731224604.GA24887@tsunami.ccur.com> <20030731154740.4e21a6e2.akpm@osdl.org> <20030731231154.GB7852@rudolph.ccur.com> <20030731161703.210470ea.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731161703.210470ea.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 04:17:03PM -0700, Andrew Morton wrote:
> Joe Korty <joe.korty@ccur.com> wrote:
> >
> > I'd like to be able to write shell scrips that operate on the set of
> > /proc/[0-9]* without having to know which of the ever-changing list
> > of processes need to be avoided and which not.
> 
> Like this?
> 
> #!/bin/sh
> 
> #
> # can_set_affinity pid
> #
> can_set_affinity()
> {
> 	if [ "$(cat /proc/$1/maps)" != "" ]
> 	then
> 		return 0
> 	fi
> 	if head -1 /proc/$1/status | egrep "events|migration"
> 	then
> 		return 1
> 	else
> 		return 0
> 	fi
> }
> 
> if can_set_affinity $1
> then
> 	echo can set affinity of pid $1
> else
> 	echo cannot set affinity of pid $1
> fi


Good stuff.  I reduced it to (having trouble easily reading the original
output):

    name=$(head -1 /proc/$1/status | awk '{print $2}')
    echo -n '[' $1 '] ' $name ' '
    if [ "$(cat /proc/$1/maps)" == "" ]
    then
	    echo SAFE
    else
	    echo changeable
    fi

It catches all those that need catching, plus denies changes to some
daemons that could survive sched_setaffinity: khubd, kirqd, pdflush*,
kswapd0, scsi_eh_[01], ahc_dv_[01], kseriod, and kjournald*.

Joe
