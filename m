Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbUE1NXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUE1NXm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 09:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUE1NXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 09:23:42 -0400
Received: from 62-15-228-226.inversas.jazztel.es ([62.15.228.226]:23204 "EHLO
	servint.tedial.com") by vger.kernel.org with ESMTP id S262897AbUE1NXj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 09:23:39 -0400
From: Antonio Larrosa =?iso-8859-1?q?Jim=E9nez?= <antlarr@tedial.com>
Organization: Tedial
To: Andrew Morton <akpm@osdl.org>
Subject: Re: iowait problems on 2.6, not on 2.4
Date: Fri, 28 May 2004 15:16:41 +0200
User-Agent: KMail/1.6.1
References: <200405261743.28111.antlarr@tedial.com> <20040526205225.7a0866aa.akpm@osdl.org>
In-Reply-To: <20040526205225.7a0866aa.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200405281516.41901.antlarr@tedial.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 May 2004 05:52, you wrote:
> Antonio Larrosa Jiménez <antlarr@tedial.com> wrote:
> > My next test will be to do the "dd tests" on one of the internal hard
> > disks and use it for the data instead of the external raid.
>
> That's a logical next step.  The reduced read bandwith on the raid array
> should be fixed up before we can go any further.  I don't recall any
> reports of qlogic fc-scsi performance regressions though.

Ok, let's analyze that first.

The dd tests gave the following results:

ext3 on the internal scsi HD:
  2.4.21:
     writing : 1m14s
     reading : 1m2s
     reading+writing : 2m16s
  2.6.4:
     writing : 1m19s
     reading : 59s
     reading+writing : 2m24s

reiserfs on the internal scsi HD:
  2.4.21:
     writing : 1m15s
     reading : 1m1s 
     reading+writing : 2m22s
  2.6.4:
     writing : 1m19s
     reading : 1m 
     reading+writing : 2m25s

ext3 on the raid using qlogic fc-scsi:
  2.4.21:
     writing : 30s
     reading : 51s
     reading+writing : 1m29s
  2.6.4:
     writing : 28s
     reading : 1m26s
     reading+writing : 2m19s

reiserfs on the raid using qlogic fc-scsi:
  2.4.21:
     writing : 37s
     reading : 52s
     reading+writing : 1m37s
  2.6.4:
     writing : 25s
     reading : 1m27s
     reading+writing : 2m3s

All the tests were made 3 times, and the average taken. In the cases where 
there was too much variance, I repeated the tests some more times.

All the tests used 2Gb reads/writes (. I tried to make 8Gb reads/writes too, 
but they got up to a minute variance (maybe the HD slowed itself down due to 
temperature issues sometimes? I really don't know why this happened, but in 
any case, I couldn't make reliable tests with files of that size).

So basically, there's no difference between 2.4.21 and 2.6.4 when using the 
internal HD, but 2.6.4 is much slower when using the raid.
What I found strange is that writing to that raid is a bit faster on 2.6.4 
while reading is much slower, which I suppose is what makes the difference.

So yes, I suppose there's a regression on the qlogic fc-scsi module.

Btw, the tests I timed were:

count=2048
write() { dd if=/dev/zero of=x bs=1M count=$count ; sync }
read() { dd if=x of=/dev/null bs=1M count=$count }
readwrite() { dd if=x of=y bs=1M count=$count ; sync }

In the case of read, I did the sync just before and after the timing, but 
didn't include the sync inside the timed test.

As I said in my other mail, I can test any patch if needed.

Greetings and thanks for any help

--
Antonio Larrosa
Tecnologias Digitales Audiovisuales, S.L.
http://www.tedial.com
Parque Tecnologico de Andalucia . Málaga (Spain)
