Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbVJLNJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbVJLNJL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 09:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbVJLNJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 09:09:10 -0400
Received: from spirit.analogic.com ([204.178.40.4]:26122 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751463AbVJLNJJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 09:09:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <81b0412b0510120548k3464d355ne75cce4e5edcce1a@mail.gmail.com>
References: <434CC144.6000504@boi.at> <81b0412b0510120548k3464d355ne75cce4e5edcce1a@mail.gmail.com>
X-OriginalArrivalTime: 12 Oct 2005 13:09:08.0622 (UTC) FILETIME=[216DDAE0:01C5CF2E]
Content-class: urn:content-classes:message
Subject: Re: blocking file lock functions (lockf,flock,fcntl) do not return after timer signal
Date: Wed, 12 Oct 2005 09:09:02 -0400
Message-ID: <Pine.LNX.4.61.0510120905190.8876@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: blocking file lock functions (lockf,flock,fcntl) do not return after timer signal
Thread-Index: AcXPLiF1Cg9eMHm8R4OrRFhHPLFaxw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
Cc: <boi@boi.at>, <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Oct 2005, Alex Riesen wrote:

> On 10/12/05, "Dieter Müller (BOI GmbH)" <dieter.mueller@boi.at> wrote:
>> bug description:
>>
>> flock, lockf, fcntl do not return even after the signal SIGALRM  has
>> been raised and the signal handler function has been executed
>> the functions should return with a return value EWOULDBLOCK as described
>> in the man pages
>
> To confirm:
>
> #include <unistd.h>
> #include <sys/time.h>
> #include <sys/file.h>
> #include <time.h>
> #include <signal.h>
>
> void alrm(int sig)
> {
>    write(2, "timeout\n", 8);
> }
>
> int main(int argc, char* argv[])
> {
>    struct itimerval tv = {
>        .it_interval = {.tv_sec = 10, .tv_usec = 0},
>        .it_value = {.tv_sec = 10, .tv_usec = 0},
>    };
>    struct itimerval otv;
>
>    signal(SIGALRM, alrm);
>    setitimer(ITIMER_REAL, &tv, &otv);
>    int fd = open(argv[1], O_RDWR);
>    if ( fd < 0 )
>    {
>        perror(argv[1]);
>        return 1;
>    }
>    printf("locking...\n");
>    if ( flock(fd, LOCK_EX) < 0 )
>    {
>        perror("flock");
>        return 1;
>    }
>    printf("sleeping...\n");
>    int ch;
>    read(0, &ch, 1);
>    close(fd);
>    return 0;
> }
> -

Does your 'signal()' impliment POSIX or BSD signals? You don't know.
It's whatever the 'C' runtime library got built for. You need to
use sigaction() so you can set the flags to give you your intended
action.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.48 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
