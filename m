Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261734AbTCQPcy>; Mon, 17 Mar 2003 10:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261737AbTCQPcy>; Mon, 17 Mar 2003 10:32:54 -0500
Received: from mail.zmailer.org ([62.240.94.4]:54405 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S261734AbTCQPcw>;
	Mon, 17 Mar 2003 10:32:52 -0500
Date: Mon, 17 Mar 2003 17:43:44 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Sparks, Jamie" <JAMIE.SPARKS@cubic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: select() stress
Message-ID: <20030317154344.GG29167@mea-ext.zmailer.org>
References: <Pine.WNT.4.44.0303171010580.1544-100000@GOLDENEAGLE.gameday2000>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0303171010580.1544-100000@GOLDENEAGLE.gameday2000>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 10:28:59AM -0500, Sparks, Jamie wrote:
> Hello,
> 
>   I'm running some code ported from an sgi running Irix 6.5 on a
>   redhat 7.1 box: 2.4.7-10, i686.  Control hangs on a select()
>   statement forever.  The select is never completed, so I can't
>   check errno.

  You do set two socket fds for read monitoring, no write-sockets,
  nor exceptions, and most definitely, no timeouts.

  If, for some reason, whoever is supposed to send something to
  those sockets does not do it, e.g. due to some odd buffering
  somewhere, you are effectively stuck.


>   Please reply to me personally as I'm not currently subscribed:
>   jamie.sparks@cubic.com
> 
>   on sgi, the call is:
> 
>   select(getdtablehi(), &socklist, NULL, NULL, NULL);
> 
>   where socklist is declared as:  FD_SET socklist;
> 
>   on linux, there is no getdtablehi() equivalent, so I use
>   getdtablesize() in its place.  getdtablehi() returns the
>   number of fd's currently open and getdtablesize() returns
>   the number of fd's that *can* be open.

  I would be carefull with that, and explicitely code
  additional things to find out current highest fd in
  the interest set:

>   here's the code:
> 
>   for (;;)
>   {
	int highfd;

>     printf("CLEARING sockets\n");
>     FD_ZERO(&socklist); /* Always clear the structure first. */
>     FD_SET(Sockfd[0], &socklist);
	highfd = Sockfd[0];
>     FD_SET(Sockfd[1], &socklist);
	if (Sockfd[1] > highfd) highfd = Sockfd[1];
>
>     int len = -1;
>     bool wasDequeued =false;
>     if (!StateManager::getSaveInProgress()&& StateManager::hasQueuedPdus())
>     {
>       FD_ZERO(&socklist); /* Always clear the structure first. */
>       pdu = StateManager::dequeuePostPduProcess();
>       len = sizeof(pdu);
>       wasDequeued = true;
>       printf("PDU DEqueued from StateManager since Save has completed\n");
>     }
>     else
>     {
>       printf("prior to select\n");
>       // orig sgi if (select(getdtablehi(), &socklist, NULL, NULL, NULL) < 0)

	int rc = select(highfd + 1, &socklist, NULL, NULL, NULL);
	if (rc < 0) ...

>       /*  ****************************** */
>       /*  THIS select() STATEMENT NEVER COMPLETES */
>       /*  ****************************** */
>       if (select(getdtablesize(), &socklist, NULL, NULL, NULL) < 0)
>       {
>         if (errno != EINTR) perror("WeapTerrain");
> 	continue;
>       }
> 
>       printf("after select\n");
> 			}
>       printf("Prior to finding which socket\n");
> 
>       for (ii=0;ii<2;ii++)
>       {
>         len = -1;
>         if (FD_ISSET(Sockfd[ii],&socklist))
> 	{
>           if (!ii)
> 	  {
>             len = waitForSocketMessage(Sockfd[ii],&pdu,
> 	    sizeof(pdu));
> 	  } else if (ii)
> 	  {
> 	    len = 0;
> 	  }
> 	}
> 
> 	if (wasDequeued){len = sizeof(pdu);wasDequeued=false;}
> 
>         if (len == sizeof(pdu) && StateManager::getSaveInProgress())
> 	{
>           StateManager::queuePostPduProcess(pdu);
>           printf("incoming PDU queued in StateManager since SaveInProgress\n");
> 	  continue;
>         }
> 
>         if (len >= 0)
> 	{
> 	  printf("LEN?TYPE = %d %d\n",len, pdu.dpdu.detonation_header.type);
>         }
> 
> 
>   Please reply to me personally as I'm not currently subscribed:
>   jamie.sparks@cubic.com
> 
>   thanks,
> 
>   Jamie
