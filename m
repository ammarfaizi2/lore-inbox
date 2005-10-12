Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVJLMtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVJLMtB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 08:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbVJLMtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 08:49:01 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:57444 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751265AbVJLMtA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 08:49:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VHreY/YvZCXuHFvTz3VGz3OcMLFsu727RSYCgM9WtjirEuoAsaYQ65DcZ/iTgEEAGM5xgrYdyFaqOiBY/ngzJxt3w/s9Kx3ML9Bf8jW/apJa7pi+lgcOiGVmD0Z9leaZpSbLPkRwkaIynUBRZ4xUwgPoZXit/WWNPOTSBrW4r7s=
Message-ID: <81b0412b0510120548k3464d355ne75cce4e5edcce1a@mail.gmail.com>
Date: Wed, 12 Oct 2005 14:48:59 +0200
From: Alex Riesen <raa.lkml@gmail.com>
To: boi@boi.at
Subject: Re: blocking file lock functions (lockf,flock,fcntl) do not return after timer signal
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <434CC144.6000504@boi.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <434CC144.6000504@boi.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/05, "Dieter Müller (BOI GmbH)" <dieter.mueller@boi.at> wrote:
> bug description:
>
> flock, lockf, fcntl do not return even after the signal SIGALRM  has
> been raised and the signal handler function has been executed
> the functions should return with a return value EWOULDBLOCK as described
> in the man pages

To confirm:

#include <unistd.h>
#include <sys/time.h>
#include <sys/file.h>
#include <time.h>
#include <signal.h>

void alrm(int sig)
{
    write(2, "timeout\n", 8);
}

int main(int argc, char* argv[])
{
    struct itimerval tv = {
        .it_interval = {.tv_sec = 10, .tv_usec = 0},
        .it_value = {.tv_sec = 10, .tv_usec = 0},
    };
    struct itimerval otv;

    signal(SIGALRM, alrm);
    setitimer(ITIMER_REAL, &tv, &otv);
    int fd = open(argv[1], O_RDWR);
    if ( fd < 0 )
    {
        perror(argv[1]);
        return 1;
    }
    printf("locking...\n");
    if ( flock(fd, LOCK_EX) < 0 )
    {
        perror("flock");
        return 1;
    }
    printf("sleeping...\n");
    int ch;
    read(0, &ch, 1);
    close(fd);
    return 0;
}
