Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287149AbSAPSwb>; Wed, 16 Jan 2002 13:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287158AbSAPSvU>; Wed, 16 Jan 2002 13:51:20 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:40720 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S287163AbSAPSvI>; Wed, 16 Jan 2002 13:51:08 -0500
Date: Wed, 16 Jan 2002 19:51:06 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
Message-ID: <20020116195105.C18039@devcon.net>
Mail-Followup-To: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local>; from olaf.dietsche--list.linux-kernel@exmail.de on Tue, Jan 15, 2002 at 05:01:11PM +0100
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 05:01:11PM +0100, Olaf Dietsche wrote:
> 
> this is a new file system to control access to system resources.
> Currently it controls access to inet_bind() with ports < 1024 only.

Just some minor notes from reading the source and docs:

- It somewhat collides with the Linux Security Module project
  (http://lsm.immunix.org/). LSM is AFAIK very likely to be included
  into kernel somewhere in the 2.5 timeframe, so I don't think your
  accessfs in its current form will be included into 2.5. Also I don't
  think it will be included into 2.4 some time, as it is rather
  intrusive. This doesn't mean that I think your work is bogus, but
  you should be warned that you will most likely have to maintain it
  as a separate patch at least until you port it to LSM (which
  probably will not be possible at least in the first phase of LSM -
  read the discussions on "restrictive vs. authoritative hooks" in the
  LSM mailinglist archives).
- CAP_NET_BIND_SERVICE is ignored completely. IMHO a process with this
  capability should still be able to override the accessfs
  permissions, otherwise enabling accessfs will break every setup
  where CAP_NET_BIND_SERVICE is already used to give non-root
  processes access to low ports. At least this should be mentioned in
  the docs (and Configure.help entry!), as it means that you can't mix
  the accessfs and the capability approach on a machine (e.g. if one
  wants to migrate the services on the machine one for one). It also
  breaks any network daemons that already use CAP_NET_BIND_SERVICE
  internally (don't know of an example, but maybe there are some out
  there).
- chown()ing a port to a uid provides this uid also with the ability
  to pass on access privileges to others via chmod(). It could be
  argued if it is more sensible to restrict changing privileges to
  root (maybe CAP_NET_ADMIN is more appropriate?).

And some wishlist items:

- It would be nice if there were a way to distinguish between TCP and
  UDP ports.
- IPv6 support would be nice. This raises the question what will
  happen if a process has the privileges to bind a particular port
  with IPv6 but not with IPv4 (IPv6 listeners take IPv4 connections
  also). Is there any value in distinguishing IPv6 and IPv4 at all,
  in particular if IPv6 gets into more widespread use in the future?
- Restricting access to certain high ports would be valuable. For
  example many SQL server use those ports, and it would be nice if one
  could prevent ordinary user processes from taking over their ports
  in case the SQL daemon gets restarted or the like.

At least accessfs is a nice and expandable idea. Keep up the work :-)

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
