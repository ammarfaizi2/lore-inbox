Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVCWOMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVCWOMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVCWOMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:12:15 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:30368 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261456AbVCWOKk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:10:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Az2L89U3svlaVGmstblQskwP4D1pkuwFM5pjX4zqnyfnBQ94xhzwS5SICNpWEch52XANYT8tiXfoZT7d95mya3T4Cd4SrRwwiiWLsXPyWL9zkfvstnqGTEdaX/HIsWqulverV6scXs7A5Ap4fbKQi8Mfb6l/8EKGpDpEUzaqcCM=
Date: Wed, 23 Mar 2005 15:10:36 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Dave Jones <davej@redhat.com>
Cc: rlrevell@joe-job.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Message-Id: <20050323151036.2b41b9ae.diegocg@gmail.com>
In-Reply-To: <20050323011313.GL15879@redhat.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz>
	<20050314083717.GA19337@elf.ucw.cz>
	<200503140855.18446.jbarnes@engr.sgi.com>
	<20050314191230.3eb09c37.diegocg@gmail.com>
	<1110827273.14842.3.camel@mindpipe>
	<20050323013729.0f5cd319.diegocg@gmail.com>
	<1111539217.4691.57.camel@mindpipe>
	<20050323011313.GL15879@redhat.com>
X-Mailer: Sylpheed version 1.9.6+svn (GTK+ 2.6.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 22 Mar 2005 20:13:15 -0500,
Dave Jones <davej@redhat.com> escribió:

> With something like this, and some additional bookkeeping to keep track of
> which files we open in the first few minutes of uptime, we could periodically
> reorganise the layout back to an optimal state.

That wouldn't be too hard (a libc wrapper could do it, right?) But how could you get
track of "code page faults"? Perhaps it's not worth of it "preloading" the parts of the 
executable (and linked libraries) used and it's much simpler to read everything? (Andrew
Morton suggested in the past using mincore(2) IIRC)

Altought even if you optimize the disk's layout and pre-read everything you need, a big
problem is the initscript scripts. I don't think it's init fault, handling absolutely _everything_
trough scripts is not going to help, specially when all^Wmost of linux systems use a
shell which claims to be "too big and too slow" in its own man page ;)
There're some shells (like zsh) which can "compile" scripts and generate "bytecode"
I wonder if that would help (zsh seems to handle bash scripts so it may be interesting
to try) Although like many people suggested, microsoft's "magic wand" to speed up
everything could have been "lets save a suspend image of the system just before
detecting  new non-critical hardware and use it to boot the system". I guess its not
possible to save/load suspend images to/from a filesystem?


So, a list of steps needed (which doesn't means I'm voluntering to do all of them 8) could
be:

1- Be able to keep track of what a process does in its whole life, or in the first N
	seconds (optimizing system's startup it's nice, but being able to speed up how
	fast openoffice loads when the system is already up would be even better).
	Using LD_PRELOAD=/something command could do this?
	
2- Get the on-disk info, port Andrew Morton's "move block" patch to 2.6, and use it
	to reorganize the disk's layout periodically (specially when package managers install
	something, ie: if people runs mozilla very often, mozilla files should be kept in the same
	place of the disk than all its libraries), using stadistics from step 1

3 - Create a tool which looks at all the data got from step 1 and "preloads" optimally from
	disk all the neccesary data (ie: using the path of one program, or several if you want
	to run two programs at the same time), with the reorganization done in step 2 it'd be
	even faster. Boot scripts would be just another user, and gnome and kde could use it
	too for single programs. If the tool detects that a program has been changed (looking
	at the "changed date" field for example) it could launch the process with the tools from
	step 1, so the stadistics get regenerated again.

Is there something crazy in this idea?
