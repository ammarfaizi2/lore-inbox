Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264175AbUE1Wt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264175AbUE1Wt5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 18:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUE1WtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 18:49:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:9891 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264002AbUE1Wmz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 18:42:55 -0400
Date: Fri, 28 May 2004 15:45:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Antonio Larrosa =?ISO-8859-1?Q?Jim=E9nez?= <antlarr@tedial.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: iowait problems on 2.6, not on 2.4
Message-Id: <20040528154525.6ed5f7b9.akpm@osdl.org>
In-Reply-To: <200405281516.41901.antlarr@tedial.com>
References: <200405261743.28111.antlarr@tedial.com>
	<20040526205225.7a0866aa.akpm@osdl.org>
	<200405281516.41901.antlarr@tedial.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Larrosa Jiménez <antlarr@tedial.com> wrote:
>
> On Thursday 27 May 2004 05:52, you wrote:
> > Antonio Larrosa Jiménez <antlarr@tedial.com> wrote:
> > > My next test will be to do the "dd tests" on one of the internal hard
> > > disks and use it for the data instead of the external raid.
> >
> > That's a logical next step.  The reduced read bandwith on the raid array
> > should be fixed up before we can go any further.  I don't recall any
> > reports of qlogic fc-scsi performance regressions though.
> 
> Ok, let's analyze that first.
> 
> The dd tests gave the following results:

Let me cc linux-scsi.

Guys: poke.  Does anyone know why this:

  The machine is a 4 cpu Pentium III (Cascades) system with four SCSI
  SEAGATE ST336704 hard disks connected to an Adaptec AIC-7899P U160/m, and
  a external RAID connected to a QLA2200/QLA2xxx FC-SCSI Host Bus Adapter. 
  The machine has 1Gb RAM.

got all slow at reads?


> ext3 on the internal scsi HD:
>   2.4.21:
>      writing : 1m14s
>      reading : 1m2s
>      reading+writing : 2m16s
>   2.6.4:
>      writing : 1m19s
>      reading : 59s
>      reading+writing : 2m24s
> 
> reiserfs on the internal scsi HD:
>   2.4.21:
>      writing : 1m15s
>      reading : 1m1s 
>      reading+writing : 2m22s
>   2.6.4:
>      writing : 1m19s
>      reading : 1m 
>      reading+writing : 2m25s
> 
> ext3 on the raid using qlogic fc-scsi:
>   2.4.21:
>      writing : 30s
>      reading : 51s
>      reading+writing : 1m29s
>   2.6.4:
>      writing : 28s
>      reading : 1m26s
>      reading+writing : 2m19s
> 
> reiserfs on the raid using qlogic fc-scsi:
>   2.4.21:
>      writing : 37s
>      reading : 52s
>      reading+writing : 1m37s
>   2.6.4:
>      writing : 25s
>      reading : 1m27s
>      reading+writing : 2m3s
> 
> All the tests were made 3 times, and the average taken. In the cases where 
> there was too much variance, I repeated the tests some more times.
> 
> All the tests used 2Gb reads/writes (. I tried to make 8Gb reads/writes too, 
> but they got up to a minute variance (maybe the HD slowed itself down due to 
> temperature issues sometimes? I really don't know why this happened, but in 
> any case, I couldn't make reliable tests with files of that size).
> 
> So basically, there's no difference between 2.4.21 and 2.6.4 when using the 
> internal HD, but 2.6.4 is much slower when using the raid.
> What I found strange is that writing to that raid is a bit faster on 2.6.4 
> while reading is much slower, which I suppose is what makes the difference.
> 
> So yes, I suppose there's a regression on the qlogic fc-scsi module.
> 
> Btw, the tests I timed were:
> 
> count=2048
> write() { dd if=/dev/zero of=x bs=1M count=$count ; sync }
> read() { dd if=x of=/dev/null bs=1M count=$count }
> readwrite() { dd if=x of=y bs=1M count=$count ; sync }
> 
> In the case of read, I did the sync just before and after the timing, but 
> didn't include the sync inside the timed test.
> 
> As I said in my other mail, I can test any patch if needed.
> 
> Greetings and thanks for any help
> 
> --
> Antonio Larrosa
> Tecnologias Digitales Audiovisuales, S.L.
> http://www.tedial.com
> Parque Tecnologico de Andalucia . Málaga (Spain)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
