Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264024AbRFMQJz>; Wed, 13 Jun 2001 12:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264026AbRFMQJq>; Wed, 13 Jun 2001 12:09:46 -0400
Received: from sense-robertk-129.oz.net ([216.39.160.129]:13184 "HELO
	mail.kleemann.org") by vger.kernel.org with SMTP id <S264024AbRFMQJk>;
	Wed, 13 Jun 2001 12:09:40 -0400
Date: Wed, 13 Jun 2001 09:09:34 -0700 (PDT)
From: Robert Kleemann <robert@kleemann.org>
X-X-Sender: <robert@localhost.localdomain>
To: Andi Kleen <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Client receives TCP packets but does not ACK
In-Reply-To: <oup1yoon4to.fsf@pigdrop.muc.suse.de>
Message-ID: <Pine.LNX.4.33.0106130856050.1153-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jun 2001, Andi Kleen wrote:
> The packet likely doesn't fit into the socket buffer and is silently
> dropped. The TCP stack doesn't force an ACK in this case, but it
> probably should, although it wouldn't solve the deadlock. The deadlock
> will be only solved if the local application reads data and clears the
> socket buffer. If you have a single packet that is bigger than the
> empty socket buffer / 2 you lose.
>
> You can check the allocated socket buffer size using netstat.

Thanks for the quick response!

I tried most of the netstat options and was unable to see the buffer size.
I do see the Recv-Q and the Send-Q which are usually zero except when the
client stops ack-ing and then the server's Send-Q starts filling up.

> You can increase it using the /proc/sys/net/core/rmem_{default,max}
> sysctls; in 2.4 there is also a TCP memory limit that can be tuned
> using /proc/sys/net/ipv4/tcp_mem. Doubling one of these will probably
> fix your problems.

On the client:
/proc/sys/net/core/rmem_default = 65535
/proc/sys/net/core/rmem_max = 65535
/proc/sys/net/ipv4/tcp_mem = 48128	48640	49152

On the server:
/proc/sys/net/core/rmem_default = 65535
/proc/sys/net/core/rmem_max = 65535
/proc/sys/net/ipv4/tcp_mem = 23552	24064	24576

The "bad" packet that seems to cause all the problems is only 1448
bytes long so I don't think insufficient buffers is the problem.
After the client stops ack-ing I can watch the server's Send-Q slowly
rise 2K, 4K, 6K, but it never comes close to these buffer limits.

Robert.

