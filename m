Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272226AbRHXVpD>; Fri, 24 Aug 2001 17:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272328AbRHXVoy>; Fri, 24 Aug 2001 17:44:54 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:21777 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S272226AbRHXVon> convert rfc822-to-8bit; Fri, 24 Aug 2001 17:44:43 -0400
Date: Fri, 24 Aug 2001 23:42:13 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Marc <pcg@goof.com>
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010824214221.A12903@fuji.laendle>
Message-ID: <20010824230048.B1110-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Aug 2001, Marc wrote:

> On Fri, Aug 24, 2001 at 09:35:08AM +0200, Roger Larsson <roger.larsson@skelleftea.mail.telia.com> wrote:
> > And I found out that read ahead was too short for modern disks.
>
> That could well be, the problem in my case is that, with up to 1000
> clients, I fear that there might not be enough memory for effective
> read-ahead (and I think read-ahead would be counter-productive even).

Depend on the amount of memory.
If asynchronous read-ahead is working for 1000 sequential IO streams on
1000 different files with MAX_READAHEAD=31, your system needs about:

(32+32) * 1 PAGE * 1000 = 256 MB

just for read-ahead data.

> > line is the
> > -#define MAX_READAHEAD  31
> > +#define MAX_READAHEAD  511
>
> I plan to try this, however, read-ahead should IMHO be zero anyway, since
> there simply is ot enough memory, and the kernel should not do much
> read-ahead when many other requests are outstanding.

I donnot recommend you to try this value, even if the read-ahead code may
be smart enough to detect trashing and use an average value more
reasonnable.

> The real problem., however, is that read performance sinks so much when many
> readers run in parallel.
>
> What I need is many parallel reads because this helps the elevator scan the
> disk once and not jump around widely)
>
> (I have 512MB memory around 64k socket send buffer and use an additional
> 96k buffer currently for reading from disk, so effectively i do my own
> read-ahead anyway. IU just need to optimize the head movements).

The asynchronous read-ahead code tries to eliminate IO latency by starting
the next IO in advance. This is probably not useful for the situation you
describe. Optimizing the head movements in indeed the smartest thing to
try given the IO pattern you describe.

In my opinion, your system is probably trashing a lot:

Buffers : (256K + 64K + 96K) * 1000 = 416 MB. Code and various datas
(notably kernel socket datas): probably far more than 100 MB.
Total greater than 512 MB.

May-be you should either:

- Use a smaller number of clients.

or

- Increase memory size up to 1 GB, for example.

or

- Use smaller buffers, for example:
    MAX_READAHEAD=15
    32K file buffer
    32K socket buffer

--

Regards,
  Gérard.


