Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261731AbTCQPUY>; Mon, 17 Mar 2003 10:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261734AbTCQPUY>; Mon, 17 Mar 2003 10:20:24 -0500
Received: from express.corp.cubic.com ([149.63.71.200]:7163 "EHLO
	express.corp.cubic.com") by vger.kernel.org with ESMTP
	id <S261731AbTCQPUW>; Mon, 17 Mar 2003 10:20:22 -0500
From: "Sparks, Jamie" <JAMIE.SPARKS@cubic.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 17 Mar 2003 10:28:59 -0500 (Eastern Standard Time)
Subject: select() stress
Message-ID: <Pine.WNT.4.44.0303171010580.1544-100000@GOLDENEAGLE.gameday2000>
X-X-Sender: sparksj@curly.ds.cubic.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

  I'm running some code ported from an sgi running Irix 6.5 on a
  redhat 7.1 box: 2.4.7-10, i686.  Control hangs on a select()
  statement forever.  The select is never completed, so I can't
  check errno.

  Please reply to me personally as I'm not currently subscribed:
  jamie.sparks@cubic.com

  on sgi, the call is:

  select(getdtablehi(), &socklist, NULL, NULL, NULL);

  where socklist is declared as:  FD_SET socklist;

  on linux, there is no getdtablehi() equivalent, so I use
  getdtablesize() in its place.  getdtablehi() returns the
  number of fd's currently open and getdtablesize() returns
  the number of fd's that *can* be open.

  here's the code:

  for (;;)
  {
    printf("CLEARING sockets\n");
    FD_ZERO(&socklist); /* Always clear the structure first. */
    FD_SET(Sockfd[0], &socklist);
    FD_SET(Sockfd[1], &socklist);

    int len = -1;
    bool wasDequeued =false;
    if (!StateManager::getSaveInProgress()&& StateManager::hasQueuedPdus())
    {
      FD_ZERO(&socklist); /* Always clear the structure first. */
      pdu = StateManager::dequeuePostPduProcess();
      len = sizeof(pdu);
      wasDequeued = true;
      printf("PDU DEqueued from StateManager since Save has completed\n");
    }
    else
    {
      printf("prior to select\n");
      // orig sgi if (select(getdtablehi(), &socklist, NULL, NULL, NULL) < 0)

      /*  ****************************** */
      /*  THIS select() STATEMENT NEVER COMPLETES */
      /*  ****************************** */
      if (select(getdtablesize(), &socklist, NULL, NULL, NULL) < 0)
      {
        if (errno != EINTR) perror("WeapTerrain");
	continue;
      }

      printf("after select\n");
			}
      printf("Prior to finding which socket\n");

      for (ii=0;ii<2;ii++)
      {
        len = -1;
        if (FD_ISSET(Sockfd[ii],&socklist))
	{
          if (!ii)
	  {
            len = waitForSocketMessage(Sockfd[ii],&pdu,
	    sizeof(pdu));
	  } else if (ii)
	  {
	    len = 0;
	  }
	}

	if (wasDequeued){len = sizeof(pdu);wasDequeued=false;}

        if (len == sizeof(pdu) && StateManager::getSaveInProgress())
	{
          StateManager::queuePostPduProcess(pdu);
          printf("incoming PDU queued in StateManager since SaveInProgress\n");
	  continue;
        }

        if (len >= 0)
	{
	  printf("LEN?TYPE = %d %d\n",len, pdu.dpdu.detonation_header.type);
        }

        .
        .
        .

  Please reply to me personally as I'm not currently subscribed:
  jamie.sparks@cubic.com

  thanks,

  Jamie
