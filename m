Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbVIILOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbVIILOc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbVIILOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:14:32 -0400
Received: from port-212-202-160-2.static.qsc.de ([212.202.160.2]:61708 "EHLO
	imr-mail.intra.in-medias-res.com") by vger.kernel.org with ESMTP
	id S1030238AbVIILOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:14:32 -0400
Message-ID: <43216F0F.3040104@in-medias-res.com>
Date: Fri, 09 Sep 2005 13:16:31 +0200
From: =?ISO-8859-15?Q?sch=F6nfeld_/_in-medias-res?= 
	<schoenfeld@in-medias-res.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
References: <S932080AbVIGI45/20050907085657Z+286@vger.kernel.org>	 <431ECA16.8040104@in-medias-res.com> <1126095079.28456.18.camel@imp.csi.cam.ac.uk> <431EF5CD.9050006@in-medias-res.com> <431F143F.2070904@vc.cvut.cz> <43213B7E.9050207@in-medias-res.com> <432167F1.8020902@vc.cvut.cz>
In-Reply-To: <432167F1.8020902@vc.cvut.cz>
X-Enigmail-Version: 0.92.0.0
X-SA-Exim-Connect-IP: 192.168.2.172
X-SA-Exim-Mail-From: schoenfeld@in-medias-res.com
Subject: Re: ncpfs: Connection invalid / Input-/Output Errors
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Bogosity: No, tests=bogofilter, spamicity=0.500000, version=0.92.1
   int  cnt   prob  spamicity histogram
  0.00   12 0.015028 0.008457 ############
  0.10    1 0.121562 0.014139 #
  0.20    0 0.000000 0.014139 
  0.30    0 0.000000 0.014139 
  0.40    0 0.000000 0.014139 
  0.50    0 0.000000 0.014139 
  0.60    0 0.000000 0.014139 
  0.70    0 0.000000 0.014139 
  0.80    0 0.000000 0.014139 
  0.90   11 0.993553 0.500638 ###########
X-SA-Exim-Version: 4.0 (built Mon, 19 Jul 2004 17:01:11 +0200)
X-SA-Exim-Scanned: Yes (on imr-mail.intra.in-medias-res.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec schrieb:
> schönfeld / in-medias-res wrote:
> 
>> Hi Petr,
>>
>> the two servers is that the one with the problems does run a nagios nrpe
>> server and some plugins, e.g. to check disk space on the novell disk,
>> while the other server does not. Now i found that heavy operations on
>> the filesystem (e.g. stat'ing many small files in a short time) is a
>> kind of problematic, if you want to do anything else on the filesystem
>> at the same time. The second process just hangs until the first one
>> accessing the ncp filesystem is ready with its operation. Well if
> 
> 
> You need either another CPU, or semaphore which do not suffer from
> starvation.
> Or you have to rewrite ncpfs to use some queue instead of simple
> semaphore.  What happens is that your copy process in a loop acquires
> ncp_server's semaphore, sends request to server, waits for response, and
> releases semaphore.  It does that for every request sent out.  Now your
> process comes in, finds that ncp_server's semaphore is locked, and starts
> waiting.  Other process gets answer from server, releases semaphore, and
> as both processes were just waiting before this happened, they both have
> same priority, and so one which just did up() continues to run.  And
> before waken up process gets chance to do its task, copy process sends
> another request, and so your second process goes to sleep again.

Ah thanks. That makes things a lot of clearer.

I found out that my attemption were true: the plugin really gets a KILL
signal if it exceeds the timeout. Means that the nagios check plugin is
the source of the problem (in combination with that what you did explain
AND the process which uses the ncpfs regulary and is running constant).
Now we found a solution for that. We just start the always
running process with a lower priority. That makes ncpfs access possible
while this process is running and producing load. Now: If we have the
always running process running, with low priority (nice +5), and the
nagios plugin tries to do something on the ncpfs it is able to, runs
fine and exits gracefully. Problem solved, at least until we find a
solution that does not look like a workaround ;-)

Thanks for your help! You helped me very much.

Bye
Patrick
