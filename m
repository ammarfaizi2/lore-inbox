Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbUKBVPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbUKBVPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbUKBVPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:15:00 -0500
Received: from alog0507.analogic.com ([208.224.223.44]:3968 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261608AbUKBVOD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:14:03 -0500
Date: Tue, 2 Nov 2004 16:12:09 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on common error-handling idiom
In-Reply-To: <Pine.LNX.4.53.0411022154210.28980@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0411021607400.8977@chaos.analogic.com>
References: <4187E920.1070302@nortelnetworks.com>
 <Pine.LNX.4.53.0411022154210.28980@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-1998737916-1099429929=:8977"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678434306-1998737916-1099429929=:8977
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 2 Nov 2004, Jan Engelhardt wrote:

>> There's something I've been wondering about for a while.  There is a lot=
 of code
>> in linux that looks something like this:
>>
>> err =3D -ERRORCODE
>> if (error condition)
>> =09goto out;
>
> That's because there might something as:
>
> err =3D -EPERM;
> if(error) { goto out; }
> do something;
> if(error2) { goto out; }
> do something more;
> if(error3) { goto out; }
>
> Is shorter than:
>
> if(error) { err =3D -EPERM; goto out; }
> do something;
> if(error2) { err =3D -EPERM; goto out; }
> do something more;
> if(error3) { err =3D -EPERM; goto out; }
>
>
>> Is there any particular reason why the former is preferred?  Is the comp=
iler
>
> To keep it short. Because it might have been worse than just err =3Dxxx:
>
> if(error) {
>    do this and that;
>    and more;
>    even more;
>    more more;
>    goto out;
> }
>
> Repeating that over and over is not that good. So we wrap it a little bit=
 to do
> a "staircase" deinitialization:
>
> err =3D -EPERM;
> if(error) { goto this_didnot_work; }
> ...
> err =3D -ENOSPC;
> if(error) { goto that_didnot_work; }
>
>
> this_didnot_work:
>  all uninitializations needed
>
> that_didnot_work:
>  all other uninit's
>
>  return err;
>
>
> So to summarize, it's done to reduce code whilst keeping the error code a=
round
> until we actually leave the function.
>
>
> My =FF=FF 0.02!
>
>
> Jan Engelhardt
> --=20
> Gesellschaft f=FF=FFr Wissenschaftliche Datenverarbeitung
> Am Fassberg, 37077 G=FF=FFttingen, www.gwdg.de

I think it's just to get around the "uninitialized variable"
warning when the 'C' compiler doesn't know that it will
always be initialized.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
--1678434306-1998737916-1099429929=:8977--
