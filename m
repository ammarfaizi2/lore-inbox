Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291160AbSBLSsv>; Tue, 12 Feb 2002 13:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291162AbSBLSsl>; Tue, 12 Feb 2002 13:48:41 -0500
Received: from zarjazz.demon.co.uk ([194.222.135.25]:22912 "EHLO
	zarjazz.demon.co.uk") by vger.kernel.org with ESMTP
	id <S291160AbSBLSsc>; Tue, 12 Feb 2002 13:48:32 -0500
Message-ID: <003d01c1b3f5$ce90a570$0201010a@frodo>
From: "Vincent Sweeney" <v.sweeney@barrysworld.com>
To: "Andrew Morton" <akpm@zip.com.au>, "Dan Kegel" <dank@kegel.com>
Cc: <linux-kernel@vger.kernel.org>, <coder-com@undernet.org>,
        "Dan Kegel" <dank@kegel.com>
In-Reply-To: <3C56E327.69F8B70F@kegel.com> <001901c1a900$e2bc7420$0201010a@frodo> <3C58D50B.FD44524F@kegel.com> <001d01c1aa8e$2e067e60$0201010a@frodo> <3C5CEEED.E98D35B7@kegel.com> <3C5CF686.1145AE14@zip.com.au>
Subject: Re: PROBLEM: high system usage / poor SMP network performance
Date: Tue, 12 Feb 2002 18:48:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I've recoded the poll() section in the ircu code base as follows:

Instead of the default :

    ...
    nfds = poll(poll_fds, pfd_count, timeout);
    ...

we now have

    ...
    nfds = poll(poll_fds, pfd_count, 0);
    if (nfds == 0) {
      usleep(1000000 / 10); /* sleep 1/10 second */
      nfds = poll(poll_fds, pfd_count, timeout);
    }
    ...

And as 'top' results now show, instead of maxing out a dual P3-800 we now
only use a fraction of that without any noticable side effects.

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
14684 ircd      15   0 81820  79M   800 S    22.5 21.2 215:39 ircd
14691 ircd      12   0 80716  78M   800 S    21.1 20.9 212:22 ircd


Vince.

----- Original Message -----
From: "Andrew Morton" <akpm@zip.com.au>
To: "Dan Kegel" <dank@kegel.com>
Cc: "Vincent Sweeney" <v.sweeney@barrysworld.com>;
<linux-kernel@vger.kernel.org>; <coder-com@undernet.org>; "Kevin L.
Mitchell" <klmitch@mit.edu>
Sent: Sunday, February 03, 2002 8:36 AM
Subject: Re: PROBLEM: high system usage / poor SMP network performance


> Dan Kegel wrote:
> >
> > Before I did any work, I'd measure CPU
> > usage under a simulated load of 2000 clients, just to verify that
> > poll() was indeed a bottleneck (ok, can't imagine it not being a
> > bottleneck, but it's nice to have a baseline to compare the improved
> > version against).
>
> I half-did this earlier in the week.  It seems that Vincent's
> machine is calling poll() maybe 100 times/second.  Each call
> is taking maybe 10 milliseconds, and is returning approximately
> one measly little packet.
>
> select and poll suck for thousands of fds.  Always did, always
> will.  Applications need to work around this.
>
> And the workaround is rather simple:
>
> ....
> + usleep(100000);
> poll(...);
>
> This will add up to 0.1 seconds latency, but it means that
> the poll will gather activity on ten times as many fds,
> and that it will be called ten times less often, and that
> CPU load will fall by a factor of ten.
>
> This seems an appropriate hack for an IRC server.  I guess it
> could be souped up a bit:
>
> usleep(nr_fds * 50);
>
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

