Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268764AbUILSSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268764AbUILSSz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268766AbUILSSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:18:55 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:27916 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268764AbUILSSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:18:53 -0400
Date: Sun, 12 Sep 2004 20:18:43 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Wolfpaw - Dale Corse <admin@wolfpaw.net>
Cc: peter@mysql.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
Message-ID: <20040912181843.GA3619@alpha.home.local>
References: <029201c498d8$dff156f0$0300a8c0@s> <001c01c498df$8d2cd0f0$0200a8c0@wolf> <20040912175946.GA3491@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912175946.GA3491@alpha.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again, Dale,

I forgot to say that you don't need to fear releasing your exploit. I
developped its equivalent 4 years ago to stress-test web servers and
proxies, and if I launch it against victim:23, I get the exact same
result within seconds : a CLOSE_WAIT socket :

attacker> ./connectdata 10.0.3.2 23 200 1
ERROR: connect()=-1, nbconn=134 : Connection refused
ERROR: connect()=-1, nbconn=135 : Connection refused
ERROR: connect()=-1, nbconn=136 : Connection refused
ERROR: connect()=-1, nbconn=137 : Connection refused

The program connects 200 sockets to the same IP:port, and sends the begining
of an HTTP request.

victim> sudo netstat -atnp|grep -v LISTEN
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name   
tcp       17      0 10.0.3.2:23             10.0.3.1:38214          CLOSE_WAIT  1333/inetd          

It's even not necessary to send data, then even faster to block my very old
inetd :

attacker> ./connectdata-nb 10.0.3.2 23 200
200 connections established.
Press any key so exit.

This time, it sends 200 non-blocking connect() calls without any data. It
takes a fraction of a second with the same result. Hopefully, it'll will
help Peter and you reproduce the problem faster on mysql.

Both programs have been freely available here for two years ; I didn't think
they would be useful again !

   http://w.ods.org/tools/connect/

Regards,
Willy

