Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131156AbQK3UGJ>; Thu, 30 Nov 2000 15:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131157AbQK3UF7>; Thu, 30 Nov 2000 15:05:59 -0500
Received: from [62.254.209.2] ([62.254.209.2]:13049 "EHLO cam-gw.zeus.co.uk")
        by vger.kernel.org with ESMTP id <S130882AbQK3TZd>;
        Thu, 30 Nov 2000 14:25:33 -0500
Date: Thu, 30 Nov 2000 18:54:56 +0000 (GMT)
From: Ben Mansell <ben@zeus.com>
To: Andi Kleen <ak@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: TCP push missing with writev()
In-Reply-To: <20001130191414.A13814@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.30.0011301816300.8071-100000@artemis.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2000, Andi Kleen wrote:

> > The problem is that if data happens to be written via method (2), then
> > the PUSH flag is never set on any packets generated. This is a bug,
> > surely?
>
> I just tried it on 2.2.17 and 2.4.0test11 and it sets PUSH for writev()
> for both cases just fine. Maybe you could supply a test program and tcpdump
> logs for what you think is wrong ?

BTW, Nagle turned off for all connections.
I can't supply source, but here are some TCP dumps of whats happening.
They're of HTTP, with a Windows IE refreshing a web page. I'll include
just one of the connections.
electra: win98, artemis: 2.4.0-test10

First of all, using write():

18:41:08.714801 electra.1057 > artemis.www: S 984816:984816(0) win 8192 <mss 1460,nop,nop,sackOK> (DF)
18:41:08.714864 artemis.www > electra.1057: S 319022729:319022729(0) ack 984817 win 5840 <mss 1460,nop,nop,sackOK> (DF)
18:41:08.715228 electra.1057 > artemis.www: . ack 1 win 8760 (DF)
18:41:08.734268 electra.1057 > artemis.www: P 1:288(287) ack 1 win 8760 (DF)
18:41:08.734354 artemis.www > electra.1057: . ack 288 win 6432 (DF)
18:41:08.745542 artemis.www > electra.1057: P 1:85(84) ack 288 win 6432 (DF)
18:41:08.754096 electra.1057 > artemis.www: P 288:568(280) ack 85 win 8676 (DF)
18:41:08.754150 artemis.www > electra.1057: . ack 568 win 7504 (DF)
18:41:08.770517 artemis.www > electra.1057: P 85:169(84) ack 568 win 7504 (DF)
18:41:08.825662 electra.1057 > artemis.www: P 568:798(230) ack 169 win 8592 (DF)
18:41:08.825742 artemis.www > electra.1057: . ack 798 win 8576 (DF)
18:41:08.856386 artemis.www > electra.1057: P 169:1230(1061) ack 798 win 8576 (DF)
18:41:08.885806 electra.1057 > artemis.www: R 985614:985614(0) win 0 (DF)

Now using writev() (all of which use two buffers, the second one empty):

18:40:15.434759 electra.1054 > artemis.www: S 931532:931532(0) win 8192 <mss 1460,nop,nop,sackOK> (DF)
18:40:15.434820 artemis.www > electra.1054: S 272275362:272275362(0) ack 931533 win 5840 <mss 1460,nop,nop,sackOK> (DF)
18:40:15.435149 electra.1054 > artemis.www: . ack 1 win 8760 (DF)
18:40:15.468973 electra.1054 > artemis.www: P 1:288(287) ack 1 win 8760 (DF)
18:40:15.469037 artemis.www > electra.1054: . ack 288 win 6432 (DF)
18:40:15.485787 artemis.www > electra.1054: . 1:85(84) ack 288 win 6432 (DF)
18:40:15.592677 electra.1054 > artemis.www: . ack 85 win 8676 (DF)
18:40:15.897950 electra.1054 > artemis.www: P 288:568(280) ack 85 win 8676 (DF)
18:40:15.897977 artemis.www > electra.1054: . ack 568 win 7504 (DF)
18:40:15.900336 artemis.www > electra.1054: . 85:169(84) ack 568 win 7504 (DF)
18:40:16.092696 electra.1054 > artemis.www: . ack 169 win 8592 (DF)
18:40:16.396061 electra.1054 > artemis.www: P 568:798(230) ack 169 win 8592 (DF)
18:40:16.411279 artemis.www > electra.1054: . ack 798 win 8576 (DF)
18:40:16.428007 artemis.www > electra.1054: . 169:1230(1061) ack 798 win 8576 (DF)
18:40:16.592603 electra.1054 > artemis.www: . ack 1230 win 7531 (DF)
18:40:16.895021 electra.1054 > artemis.www: R 932330:932330(0) win 0 (DF)


Ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
