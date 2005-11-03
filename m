Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbVKCBHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVKCBHP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 20:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbVKCBHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 20:07:15 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:5323 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030240AbVKCBHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 20:07:13 -0500
Subject: Re: NTP broken with 2.6.14
From: john stultz <johnstul@us.ibm.com>
To: Jean-Christian de Rivaz <jc@eclis.ch>
Cc: linux-kernel@vger.kernel.org, dean@arctic.org
In-Reply-To: <43695D94.10901@eclis.ch>
References: <4369464B.6040707@eclis.ch>
	 <1130973717.27168.504.camel@cog.beaverton.ibm.com>
	 <43694DD1.3020908@eclis.ch>
	 <1130976935.27168.512.camel@cog.beaverton.ibm.com>
	 <43695D94.10901@eclis.ch>
Content-Type: multipart/mixed; boundary="=-/aouax4iUzrmlVi62eA7"
Date: Wed, 02 Nov 2005 17:07:06 -0800
Message-Id: <1130980031.27168.527.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/aouax4iUzrmlVi62eA7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

On Thu, 2005-11-03 at 01:45 +0100, Jean-Christian de Rivaz wrote:
> john stultz a écrit :
> > On Thu, 2005-11-03 at 00:37 +0100, Jean-Christian de Rivaz wrote:
> >>john stultz a écrit :
> >>>On Thu, 2005-11-03 at 00:05 +0100, Jean-Christian de Rivaz wrote:
> >>>>Since I have installed the new kernel 2.6.14, ntpd is unable to
> >>>>synchronize the time:
> >>>
> >>>I'm working to see if I can reproduce this. Is this with 2.6.14 vanilla,
> >>>or from Linus' git tree post 2.6.14?
> >>
> >>This is a vanilla 2.6.14 kernel from Linus git tree.
> >>The architecture is i386:
> >>Linux talla 2.6.14 #1 PREEMPT Tue Nov 1 17:27:04 CET 2005 i686 GNU/Linux
> > 
> > I can't seem to trivially reproduce this.
> > 
> > 
> > Your ntpq associations output looks suspicious, though. 
> > ind assID status  conf reach auth condition  last_event cnt
> > ===========================================================
> >    1 14484  9014   yes   yes  none    reject   reachable  1
> > 
> > That reject condition seems odd.
> > 
> > What does running "ntpdate -uq <server>" produce?
> 
> First I have rebooted with a new kernel 2.6.14 that have the patch 
> pointed out by Dean Gaudet, this don't change the problem.
> 
> On the machine with 2.6.14:
> 
> talla:~# uname -a
> Linux talla 2.6.14-1 #2 PREEMPT Thu Nov 3 00:54:44 CET 2005 i686 GNU/Linux
> talla:~# ntpdate -uq 10.0.0.1
> server 10.0.0.1, stratum 3, offset -14.893095, delay 0.02644
>   3 Nov 01:31:59 ntpdate[8186]: step time server 10.0.0.1 offset 
> -14.893095 sec

Hmm. Ok, so network wise you seem to be communicating with the server
without an issue. The other reasons for a reject condition are sync-loop
(your NTP server isn't synced to your box I'd assume), or your host is
drifting too severely from the NTP server for ntpd to compensate.

Attached is a cruddy python script I wrote that should provide you with
your ppm drift from your server.
To run:
o Disable ntpd
o Run "./drift-test.py <server>"
o Let it run for 10 minutes to get a decent drift value.


> citron:~# uname -a
> Linux citron 2.6.12-nfs-1 #1 Fri Jun 24 18:23:39 CEST 2005 i686 GNU/Linux
> citron:~# ntpdate -uq 10.0.0.1
> server 10.0.0.1, stratum 3, offset 0.003676, delay 0.02647
>   3 Nov 01:32:06 ntpdate[13476]: adjust time server 10.0.0.1 offset 
> 0.003676 sec
> citron:~# ntpdate -uq 129.132.2.21
> server 129.132.2.21, stratum 2, offset -0.010485, delay 0.04341
>   3 Nov 01:32:11 ntpdate[13477]: adjust time server 129.132.2.21 offset 
> -0.010485 sec
> 
> So this could to be something after the 2.6.12. All machines run the 
> same version of ntpd and use the same configuration file.

Would you mind confirming 2.6.12 does not have the issue on the same
hardware?

thanks
-john


--=-/aouax4iUzrmlVi62eA7
Content-Disposition: attachment; filename=drift-test.py
Content-Type: text/x-python; name=drift-test.py; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#!/usr/bin/python
import commands
import sys
import string
import time


#default args
server = ""
sleep_time = 60

#parse args
if len(sys.argv) > 1:
	server = sys.argv[1]
if len(sys.argv) > 2:
	sleep_time = string.atoi(sys.argv[2])

#set time
cmd = commands.getoutput('/usr/sbin/ntpdate -ub ' + server)

cmd = commands.getoutput('/usr/sbin/ntpdate -uq ' + server)
line = string.split(cmd)

#parse original offset
start_offset = string.atof(line[-2]);
#parse original time
start_time = time.localtime(time.time())
datestr = time.strftime("%d %b %Y %H:%M:%S", start_time)

time.sleep(1)
while 1:
	cmd = commands.getoutput('/usr/sbin/ntpdate -uq ' + server)
	line = string.split(cmd)

	#parse offset
	now_offset = string.atof(line[-2]);

	#parse time
	now_time = time.localtime(time.time())
	datestr = time.strftime("%d %b %Y %H:%M:%S", now_time)

	# calculate drift
	delta_time = time.mktime(now_time) - time.mktime(start_time)
	delta_offset = now_offset - start_offset
	drift =  delta_offset / delta_time * 1000000

	#print output
	print time.strftime("%d %b %H:%M:%S",now_time), 
	print "	offset:", now_offset , 
	print "	drift:", drift ,"ppm"
	sys.stdout.flush()

	#sleep 
	time.sleep(sleep_time)

--=-/aouax4iUzrmlVi62eA7--

