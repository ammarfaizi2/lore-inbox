Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUCAL0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 06:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbUCAL0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 06:26:38 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:31934 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261207AbUCAL0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 06:26:33 -0500
Date: Mon, 1 Mar 2004 12:26:31 +0100
From: bert hubert <ahu@ds9a.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, wrona@mat.uni.torun.pl,
       golbi@mat.uni.torun.pl
Subject: posix message queues, was Re: 2.6.4-rc1-mm1
Message-ID: <20040301112631.GA28526@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	wrona@mat.uni.torun.pl, golbi@mat.uni.torun.pl
References: <20040229140617.64645e80.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040229140617.64645e80.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 02:06:17PM -0800, Andrew Morton wrote:

> - Added the POSIX message queue implementation.  We're still stitching
>   together a decent description of all of this.  Reference information is at
> 	http://www.mat.uni.torun.pl/~wrona/posix_ipc/
>  and
> 	http://www.opengroup.org/onlinepubs/007904975/basedefs/mqueue.h.html

I can confirm that basic functionality is there. Both blocking and
nonblocking operations work as advertised. Queue properly blocks when full
or empty.

mq_timedsend does not wait, it immediately returns ETIMEOUT with the queue
is full:

         struct timespec ts;
         ts.tv_sec=1;
    	 ts.tv_nsec=0;
         sprintf(msgptr,"%05d %s",c,stime);
	 
         if ( mq_timedsend(mqd,msgptr,msglen,msg_prio, &ts) )
	 {
	    perror("mq_send()");
	      break;
	 }

results in:

$ ./mqreceive /Q32x128
1: priority 0  len 64 text 00001 Mon Mar  1 12:20:11 2004  
$ ./mqreceive /Q32x128
1: priority 0  len 64 text 00001 Mon Mar  1 12:20:11 2004  
$ ./mqsend  /Q32x128
$ ./mqsend  /Q32x128
$ ./mqsend  /Q32x128
mq_send(): Connection timed out  <- immediately

Queue is in blocking mode.

I would very much advise Michal and Krzysztof to add some basic examples to
their page. I had to scour the internet to find some working code.

This is one of the few sites that allow you to test the posix message queue:
http://www.ac3.edu.au/SGI_Developer/books/T_IRIX_Prog/sgi_html/ch06.html

The examples there add /var/tmp/ to the queuenames, with linux, posix queues
need to have a name that starts with /.

Mounting the queuefs works but the fs, confusingly, is called mqueue and not
mqueuefs.

Otherwise sound work! PowerDNS really wants posix message queues, right now
we fuddle along with semaphores and locks.

Thanks,
Bert.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
