Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131671AbRBAXqm>; Thu, 1 Feb 2001 18:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131967AbRBAXqc>; Thu, 1 Feb 2001 18:46:32 -0500
Received: from melancholia.danann.net ([203.36.211.210]:37898 "HELO
	melancholia.danann.net") by vger.kernel.org with SMTP
	id <S131671AbRBAXqS>; Thu, 1 Feb 2001 18:46:18 -0500
To: dmeyer@dmeyer.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: What does "NAT: dropping untracked packet" mean?
Keywords: packet,packets,message,untracked,netfilter,icmp,floor,feb
In-Reply-To: <20010201133811.D14768@ipe.uni-stuttgart.de>
	<20010201181952.A5803@jhereg.dmeyer.net>
In-Reply-To: <20010201181952.A5803@jhereg.dmeyer.net> (dmeyer@dmeyer.net's message of "Thu, 1 Feb 2001 18:19:52 -0500")
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
X-Homepage: http://danann.net/
X-spies: Qaddafi [Hello to all my fans in domestic surveillance] Treasury BATF Nazi NWO NORAD DES Legion of Doom ammunition fissionable Kibo Albania arrangements militia 
Date: 02 Feb 2001 10:45:00 +1100
Message-ID: <87puh26k8z.fsf@inanna.rimspace.net>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.2 (Terspichore)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmeyer  <dmeyer@dmeyer.net> writes:
>
> In article <20010201151717.D5706@emma1.emma.line.org> you write:
>> On Thu, 01 Feb 2001, Nils Rennebarth wrote:
>> > Feb 1 12:58:56 obelix kernel: NAT: 0 dropping untracked packet
>> ce767600 1 129.69.22.21 -> 224.0.0.2
>>
>> It means that your box drops multicast administrative packets on the
>> floor.
>
> I'm getting the occasional
>
> Feb 1 13:17:08 yendi kernel: NAT: 0 dropping untracked packet c3ea4da0
> 1 146.188.249.73 -> 209.220.232.240
>
> syslog message. What exactly does it mean? 146.188.249.73 isn't my
> machine at all, and 209.220.232.240 is my firewall. I assume I'm
> dropping someone's packets on the floor, but what can cause a packet
> to get dropped like that?

The one big thing I know of that causes these messages is a
long-standing bug in the FreeBSD and OpenBSD (and presumably NetBSD, I
don't know about that one, though) network stacks.

When sending an ICMP host unreachable response to a DF packet, some of
the packet was byte-swapped.

The bytes were *only* in the segment of the original IP packet appended
to the ICMP message for identification purposes.

Under normal conditions this packet works fine with Linux. The
connection is killed, all is fine.

When running netfilter and connection tracking, netfilter uses these
byte-swapped fields to associate the ICMP message with the original TCP
or UDP packets.

Because the fields are out-of-order, this match fails. netfilter then
drops the packet on the floor and generates the 'untracked packet'
message.

FreeBSD have fixes their network stack not that long ago. I believe that
their 5.0 release corrects the bug, but I am not sure of that. Check
with them if you really care.

I don't believe that OpenBSD have corrected this problem at this stage
but, again, I have not checked recently. Check with them if you really
care.


This bug is *only* triggered when the packet has DF set. Normal packets
don't trigger that particular buggy code path.

        Daniel

-- 
The truth knocks on the door and you say, 'Go away, I'm looking for
the truth,' and so it goes away. Puzzling...
        -- Robert Pirsig
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
