Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSCKHm2>; Mon, 11 Mar 2002 02:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291074AbSCKHmU>; Mon, 11 Mar 2002 02:42:20 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:12494 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S284180AbSCKHmF>; Mon, 11 Mar 2002 02:42:05 -0500
Date: Mon, 11 Mar 2002 08:41:54 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Oskar Liljeblad <oskar@osk.mine.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: directory notifications lost after fork?
Message-ID: <20020311084154.C4573@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Oskar Liljeblad <oskar@osk.mine.nu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020310210802.GA1695@oskar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020310210802.GA1695@oskar>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a "me too".
I have tried also to use the default (SIGIO) by setting owner pid (just
in case). It is all the same.
Does someone use the notifications, btw?
The whole thing seems somewhat untested.
-alex

On Sun, Mar 10, 2002 at 10:08:02PM +0100, Oskar Liljeblad wrote:
> The code snipper demonstrates what I consider a bug in the
> dnotify facilities in the kernel. After a fork, all registered
> notifications are lost in the process where they originally
> where registered (the parent process). "lost" here means that
> the signal specified with F_SETSIG fcntl no longer is delivered
> when notified.
> 
> How to reproduce (tested with 2.4.17):
>   gcc -o dnoticebug dnoticebug.c
>   dnoticebug &				# run in background
>   cat dnoticebug.c >/dev/null		# "notified" should now be printed
>   cat dnoticebug.c >/dev/null		# nothing is printed this time
>   
> If you comment out the line with fork below, "notified" *will* be
> printed every time you cat dnoticebug.c.
> 
> I'm not subscribed to the list so I'd appreciate if you CCed me.
> (Otherwise I'd have to use the archives :) Thanks.
> 
> Oskar Liljeblad (oskar@osk.mine.nu)
> 
> ===
> 
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <signal.h>
> #include <stdio.h>
> #include <unistd.h>
> 
> static void handler(int sig, siginfo_t *si, void *data)
> {
> 	printf("notified\n");
> }
> 
> int main(void)
> {
> 	struct sigaction act;
> 	int fd;
> 
> 	act.sa_sigaction = handler;
> 	sigemptyset(&act.sa_mask);
> 	act.sa_flags = SA_SIGINFO;
> 	sigaction(SIGRTMIN, &act, NULL);
> 
> 	fd = open(".", O_RDONLY);
> 	fcntl(fd, F_SETSIG, SIGRTMIN);
> 	fcntl(fd, F_NOTIFY, DN_ACCESS|DN_MULTISHOT);
> 
> 	while (1) {
> 		pause();
> 		if (fork() <= 0) exit(0);
> 		wait(NULL);
> 	}
> }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
