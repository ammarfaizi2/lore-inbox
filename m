Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbSJ3ITD>; Wed, 30 Oct 2002 03:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSJ3ITD>; Wed, 30 Oct 2002 03:19:03 -0500
Received: from bohnice.netroute.lam.cz ([212.71.169.62]:58619 "EHLO
	vagabond.cybernet.cz") by vger.kernel.org with ESMTP
	id <S264672AbSJ3ITB>; Wed, 30 Oct 2002 03:19:01 -0500
Date: Wed, 30 Oct 2002 09:23:45 +0100
From: Jan Hudec <bulb@ucw.cz>
To: "Kenneth M. Howlett" <av556@detroit.freenet.org>
Cc: linux-kernel@vger.kernel.org, mnalis-umsdos@voyager.hr,
       chaffee@cs.berkeley.edu, bsg@uniyar.ac.ru
Subject: Re: PROBLEM: dos filesystem timestamps and daylight savings time
Message-ID: <20021030082345.GB13337@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	"Kenneth M. Howlett" <av556@detroit.freenet.org>,
	linux-kernel@vger.kernel.org, mnalis-umsdos@voyager.hr,
	chaffee@cs.berkeley.edu, bsg@uniyar.ac.ru
References: <200210300108.UAA17536@detroit.freenet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210300108.UAA17536@detroit.freenet.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 08:08:20PM -0500, Kenneth M. Howlett wrote:
> A few days ago, daylight savings time ended, and now
> ls --full-time says the timestamps of all the files on
> my dos partition have increased by one hour.
> 
> For example, ls --full-time says the timestamp of command.com is:
> last week: Tue Apr 07 06:00:00 1992
> this week: Tue Apr 07 07:00:00 1992
> 
> I think the timestamps of a dos filesystem are stored in local
> time. So the dos filesystem driver needs to convert the local
> time to unix standard time, and then ls converts back to local
> time, and displays the timestamp in local time.
> 
> I think that the problem is that the dos filesystem driver's
> local time to unix standard time algorithm is compensating for
> whether or not daylight savings time is in effect NOW. It should
> be compensating for whether or not daylight savings time was in
> effect at the time of the timestamp.
> 
> The time conversion algorithm is function date_dos2unix in file
> /usr/src/linux-2.4.19/fs/fat/misc.c. Is there a way to use
> tz_minuteswest from the the time of the timestamp instead of the
> current tz_minuteswest?
> 
> Or before returning the number of seconds, function date_dos2unix
> could determine if daylight savings time is in effect now, and if
> daylight savings time was in effect at the time of the timestamp.
> These determinations could return 0 or 1. Then subtract the two
> determinations, which will give us -1, 0, or 1. Multiply by 3600
> and add to the number of seconds.
> 
> Function fat_date_unix2dos in file
> /usr/src/linux-2.4.19/fs/fat/misc.c should have a similar fix.
> 
> ls appears to convert unix standard time to local time correctly,
> adjusting for whether or not daylight savings time was in effect
> at the time being converted. Maybe we should look at the source
> for ls, to see how ls converts time.

Yes. But it needs the /usr/share/zoneinfo/`cat /etc/timezone` file for this.
That file contains a record of when daylight saving time was in effect
for that country. It's handling is in standart C library. But kernel
does not use C library and does not load files. Thus it does not know,
weather DST was in effect at some time...

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
