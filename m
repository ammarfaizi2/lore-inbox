Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318388AbSHEL7w>; Mon, 5 Aug 2002 07:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318390AbSHEL7w>; Mon, 5 Aug 2002 07:59:52 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:6141 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318388AbSHEL7w>; Mon, 5 Aug 2002 07:59:52 -0400
Subject: Re: 2.4.19-ac1 and later: kernel BUG in apm.c:899 (SMP,
	apm=power-off)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020805053156.GA476@middle.of.nowhere>
References: <20020805053156.GA476@middle.of.nowhere>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 14:22:07 +0100
Message-Id: <1028553727.18156.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 06:31, Jurriaan wrote:
> Since 2.4.19-ac1 I occasionally (like 1 in 3 times) see an Oops while
> shutting down, containing the line
> 
> kernel BUG in apm.c:899
> 
> This is an Abit VP6 dual board, with a via chipset. Below you'll find
> lspci, (limited) dmesg, and .config information.

Basically its oopsing because it was about to make an APM call on a
processor other than CPU#0 (physical id), it set the cpus_allowed mask
to CPU#0 only and then rescheduled but ended up on a CPU that was not
CPU#0. Thats because its not making the right and proper calls for the
O(1) scheduler - Willy's patch I merged is right - but not for -ac.

I'll fix that in -ac5.

It should be enough to swap

		current->cpus_allowed = 1;

with
		set_cpus_allowed(current, 1 << cpu_logical_map(0));

		
in that file

