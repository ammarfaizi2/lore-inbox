Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261282AbSJHP0O>; Tue, 8 Oct 2002 11:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261286AbSJHP0O>; Tue, 8 Oct 2002 11:26:14 -0400
Received: from aneto.able.es ([212.97.163.22]:22145 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id <S261282AbSJHP0M>;
	Tue, 8 Oct 2002 11:26:12 -0400
Date: Tue, 8 Oct 2002 17:31:30 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Rik van Riel <riel@conectiva.com.br>
Cc: procps-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] procps 2.0.10
Message-ID: <20021008153130.GG1560@werewolf.able.es>
References: <Pine.LNX.4.44L.0210081135290.1909-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44L.0210081135290.1909-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Oct 08, 2002 at 16:38:36 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.08 Rik van Riel wrote:
>On Tue, 8 Oct 2002, J.A. Magallon wrote:
>
>> It also kills the 'states' part, things are beginning to spread past 80
>> columns...is it very important ?
>
>Yes, things should stay within 80 lines.
>
>> I am gettin also strange outputs sometimes, with a ton of digits in
>> decimal parts.
>
>Wait... I remember fixing that bug.  On 2.4 kernels iowait
>should always be 0.0% and it always is 0.0% here.
>
>I have no idea why it's displaying a wrong value on your
>system, unless you somehow managed to run against a wrong
>libproc.so (shouldn't happen).
>

Perhaps it is the percentage-mod plays. With this (calculate percentage in
0.1% units and then /10 and %10, I do not get that strange output). Perhaps
it was gcc-3.2 optimizing things, and it eats this better. It also guarantees
that decimal part never has more than 1 digit (%10 thing):

--- top.c.orig	2002-10-08 15:28:10.000000000 +0200
+++ top.c	2002-10-08 17:21:24.000000000 +0200
@@ -1691,6 +1691,8 @@
 								i, __LINE__);
 							break;
 						} else {
+							int u_delta, s_delta, n_delta, io_delta, i_delta, un_delta;
+
 							t_ticks = (u_ticks + s_ticks + i_ticks + n_ticks + io_ticks)
 							    - (u_ticks_o[i] + s_ticks_o[i] + i_ticks_o[i] + n_ticks_o[i] + io_ticks_o[i]);
 							if (Irixmode)
@@ -1699,25 +1701,21 @@
 								cpumap =
 								    cpu_mapping
 								    [i];
+							u_delta  = (trimzero(u_ticks - u_ticks_o[i])*1000)/t_ticks;
+							s_delta  = (trimzero(s_ticks - s_ticks_o[i])*1000)/t_ticks;
+							n_delta  = (trimzero(n_ticks - n_ticks_o[i])*1000)/t_ticks;
+							io_delta = (trimzero(io_ticks - io_ticks_o[i])*1000)/t_ticks;
+							i_delta  = (trimzero(i_ticks - i_ticks_o[i])*1000)/t_ticks;
+							un_delta  = (trimzero(u_ticks - u_ticks_o[i]+n_ticks - n_ticks_o[i])*1000)/t_ticks;
 							printf
-							    ("CPU%d states: %2d%s%-d%% user, %2d%s%-d%% system,"
-							     " %2d%s%-d%% nice, %2d%s%-d%% iowait, %2d%s%-d%% idle",
+							    ("CPU%d: %3d%s%-d%% user %3d%s%-d%% system"
+							     " %3d%s%-d%% nice %3d%s%-d%% iowait %3d%s%-d%% idle",
 							     cpumap,
-							     trimzero(u_ticks - u_ticks_o [i] + n_ticks - n_ticks_o [i]) * 100 / t_ticks,
-							     decimal_point,
-							     trimzero(u_ticks - u_ticks_o [i]) * 100 % t_ticks / 100,
-							     trimzero(s_ticks - s_ticks_o [i]) * 100 / t_ticks,
-							     decimal_point,
-							     trimzero(s_ticks - s_ticks_o [i]) * 100 % t_ticks / 100,
-							     trimzero(n_ticks - n_ticks_o [i]) * 100 / t_ticks,
-							     decimal_point,
-							     trimzero(n_ticks - n_ticks_o [i]) * 100 % t_ticks / 100,
-							     trimzero(io_ticks - io_ticks_o [i]) * 100 / t_ticks,
-							     decimal_point,
-							     trimzero(io_ticks - io_ticks_o [i]) * 100 % t_ticks / 100,
-							     trimzero(i_ticks - i_ticks_o [i]) * 100 / t_ticks,
-							     decimal_point,
-							     trimzero(i_ticks - i_ticks_o [i]) * 100 % t_ticks / 100);
+							     un_delta/ 10, decimal_point, un_delta% 10,
+							     s_delta / 10, decimal_point, s_delta % 10,
+							     n_delta / 10, decimal_point, n_delta % 10,
+							     io_delta/ 10, decimal_point, io_delta% 10,
+							     i_delta / 10, decimal_point, i_delta % 10);
 							s_ticks_o[i] = s_ticks;
 							u_ticks_o[i] = u_ticks;
 							n_ticks_o[i] = n_ticks;

And looks cleaner...;)

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (dolphin) for i586
Linux 2.4.20-pre9-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
