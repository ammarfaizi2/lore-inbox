Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264000AbUDQVaF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 17:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUDQVaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 17:30:05 -0400
Received: from florence.buici.com ([206.124.142.26]:9088 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264000AbUDQV37
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 17:29:59 -0400
Date: Sat, 17 Apr 2004 14:29:58 -0700
From: Marc Singer <elf@buici.com>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, elf@buici.com
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040417212958.GA8722@flea>
References: <20040417193855.GP743@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417193855.GP743@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 12:38:55PM -0700, William Lee Irwin III wrote:
> Marc Singer reported an issue where an embedded ARM system performed
> poorly due to page replacement potentially prematurely replacing
> mapped memory where there was very little mapped pagecache in use to
> begin with.
> 
> Marc Singer has results where this is an improvement, and hopefully can
> clarify as-needed. Help determining whether this policy change is an
> improvement for a broader variety of systems would be appreciated.

I have some numbers to clarify the 'improvement'.

Setup:
  ARM922 CPU, 200MHz, 32MiB RAM
  NFS mounted rootfs, tcp, hard, v3, 4K blocks
  Test application copies 41MiB file and prints the elapsed time

The two scenarios differ only in the setting of /proc/sys/vm/swappiness.

				 swappiness
			60 (default)		0
			------------		--------
elapsed time(s)		52.48			52.9
			53.13			52.91
			53.13			52.87
			52.53			53.03
			52.35			53.02
			
mean			52.72			52.94

I'd say that there is no statistically significant difference between
these sets of times.  However, after I've run the test program, I run
the command "ls -l /proc"

				 swappiness
			60 (default)		0
			------------		--------
elapsed time(s)		18			1
			30			1
			33			1
			
This is the problem.  Once RAM fills with IO buffers, the kernel's
tendency to evict mapped pages ruins interactive performance.
