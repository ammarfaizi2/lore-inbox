Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292536AbSB1AQ3>; Wed, 27 Feb 2002 19:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293091AbSB1APT>; Wed, 27 Feb 2002 19:15:19 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:53456 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293094AbSB1AOb>; Wed, 27 Feb 2002 19:14:31 -0500
From: "Nivedita Singhvi" <nivedita@us.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: What is TCPRenoRecoveryFail ?
To: bjorn.wesen@axis.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFE557C9E1.B92BBFE1-ON88256B6D.007FDDA8@boulder.ibm.com>
Date: Wed, 27 Feb 2002 16:14:26 -0800
X-MIMETrack: Serialize by Router on D03NM035/03/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/27/2002 05:14:29 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The retansmit from the Linux box should have been triggered
where that long timeout at the end begins, see below

> 1] 23:46:43.009000 10.13.18.46.http > dh10-13-18-213.axis.se.squid: .
> [tcp sum ok] 4269884068:4269885528(1460) ack 7148250 win 5840
> (DF) (ttl 64, id 37958, len 1500)

      linux -> win      send 1460 bytes

> 2] 23:46:43.009000 dh10-13-18-213.axis.se.squid > 10.13.18.46.http: .
> [tcp sum ok] ack 1460 win 8760 (DF) (ttl 128, id 54605, len 40)

      win -> linux      ack

> 3] 23:46:43.009000 10.13.18.46.http > dh10-13-18-213.axis.se.squid: .
> [tcp sum ok] 1460:2920(1460) ack 1 win 5840 (DF)
> (ttl 64, id 37959, len 1500)

      linux -> win      send 1460 bytes

> 4] 23:46:43.009000 dh10-13-18-213.axis.se.squid > 10.13.18.46.http: .
> [tcp sum ok] ack 2920 win 8760 (DF) (ttl 128, id 54861, len 40)

      win -> linux      ack

> 5] 23:46:43.010000 10.13.18.46.http > dh10-13-18-213.axis.se.squid: .
> [tcp sum ok] 2920:4380(1460) ack 1 win 5840 (DF)
> (ttl 64, id 37960, len 1500)

      linux -> win      send 1460 bytes (upto rel seq #  4380)

> 6] 23:46:43.010000 10.13.18.46.http > dh10-13-18-213.axis.se.squid: .
> [tcp sum ok] 5840:7300(1460) ack 1 win 5840 (DF)
> (ttl 64, id 37962, len 1500)

      linux -> win      send 1460 bytes (upto rel seq # 7300)

> 7] 23:46:43.010000 dh10-13-18-213.axis.se.squid > 10.13.18.46.http: .
> [tcp sum ok] ack 4380 win 8760 (DF) (ttl 128, id 55117, len 40)

      win -> linux      ack 4380 #1

> 8] 23:46:43.011000 10.13.18.46.http > dh10-13-18-213.axis.se.squid: .
> [tcp sum ok] 7300:8760(1460) ack 1 win 5840 (DF)
> (ttl 64, id 37963, len 1500)

      linux -> win      send 1460 bytes (upto rel seq # 8760)

> 9] 23:46:43.011000 dh10-13-18-213.axis.se.squid > 10.13.18.46.http: .
>  [tcp sum ok] ack 4380 win 8760 (DF) (ttl 128, id 55373, len 40)

      win -> linux      ack 4380 #2 (dup ack #1)

> 10] 23:46:43.011000 10.13.18.46.http > dh10-13-18-213.axis.se.squid: .
> [tcp sum ok] 8760:10220(1460) ack 1 win 5840 (DF)
> (ttl 64, id 37964, len 1500)

      linux -> win      send 1460 bytes (upto rel seq # 10220)

> 11] 23:46:43.011000 dh10-13-18-213.axis.se.squid > 10.13.18.46.http: .
> [tcp sum ok] ack 4380 win 8760 (DF) (ttl 128, id 55629, len 40)

      win -> linux      ack 4380 #3 (dup ack #2)

> 12] 23:46:43.012000 10.13.18.46.http > dh10-13-18-213.axis.se.squid: P
> [tcp sum ok] 10220:11680(1460) ack 1 win 5840 (DF)
> (ttl 64, id 37965, len 1500)

      linux -> win      send 1460 bytes (upto rel seq # 11680)

> 13] 23:46:43.012000 dh10-13-18-213.axis.se.squid > 10.13.18.46.http: .
> [tcp sum ok] ack 4380 win 8760 (DF) (ttl 128, id 55885, len 40)

      win -> linux      ack 4380 #4 (dup ack #3)

      !! This ack should trigger fast retransmit from the
      linux box.  Apparently the linux box didnt generate
      it, or the windows box never got it.

      Do the statistics indicate a retransmission went out?

> .. long timeout here until the server finally gives up the connection ..

> 14] 23:56:46.111000 10.13.18.46.http > dh10-13-18-213.axis.se.squid: F
> [tcp sum ok] 11680:11680(0) ack 1 win 5840 (DF) (ttl 64, id 37966, len
40)

thanks,
Nivedita


