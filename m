Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288987AbSAUAwb>; Sun, 20 Jan 2002 19:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288990AbSAUAwW>; Sun, 20 Jan 2002 19:52:22 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:2060 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S288987AbSAUAwL> convert rfc822-to-8bit; Sun, 20 Jan 2002 19:52:11 -0500
X-Envelope-From: martin.macok@underground.cz
Date: Mon, 21 Jan 2002 01:52:09 +0100
From: =?iso-8859-2?Q?Martin_Ma=E8ok?= <martin.macok@underground.cz>
To: linux-kernel@vger.kernel.org
Subject: [andrewg@tasmail.com: remote memory reading through tcp/icmp]
Message-ID: <20020121015209.A26413@sarah.kolej.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5.1i
X-Echelon: GRU NSA GCHQ CIA Pentagon nuclear conspiration war teror anthrax
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments on this?

----- Forwarded message from Andrew Griffiths <andrewg@tasmail.com> -----

Date: Sun, 20 Jan 2002 20:17:22 +1100 (EST)
From: "Andrew Griffiths" <andrewg@tasmail.com>
To: bugtraq@securityfocus.com
Subject: remote memory reading through tcp/icmp


Greets: (in no particular order)

        Marty (and others for their brilliant work with Snort)
        Fyodor (for nmap)
        LBNL Network Research Group
	zen-parse [4] and jaguar for looking over this and suggesting 
	improvements.

It is possible to read parts of a remote machines memory. To be specific, 
it would have to be memory recently freed/swapped to disk. Consider this 
for example:

int main(int argc, char **argv[], char **envp[])
{
  char *ptr=0; /* We take a rather large chunk of memory and fill it with A's */
  int val, i;

  while(1) {
    sleep(1);
    val = 30000000; // ~ 30 M
    ptr = (char *)malloc(val);

    memset(ptr, 0x41, val-1);
    free(ptr);
  }
}

And then we modify nmap(1) (Around line 687) so it only transmits the
first fragment out of a fragmented scan. This will illict a ICMP TTL 
Exceeded message. Due to Linux including a lot more of the packet than most 
other OS's, we have around 20 bytes to read. From memory, Solaris includes 
a little bit extra on ICMP messages. 

Let's look at a sniffer trace from snort(2):
  (Ignore the time stamps, as the machine this was originally done had a date
  in 1994...) 

12/11-00:34:34.290903 127.0.0.1 -> 127.0.0.1
ICMP TTL:255 TOS:0xC0 ID:29812
TTL EXCEEDED
00 00 00 00 45 00 00 24 A2 15 20 00 3E 06 BC BC  ....E..$.. .>...
7F 00 00 01 7F 00 00 01 E1 C1 01 91 FB 73 6B E2  .............sk.
00 00 00 00 50 02 08 00 41 41 41 41 41 41 41 41  ....P...AAAAAAAA
41 41 41 41 41 41 41 41 41 41 41 41              AAAAAAAAAAAA

12/11-01:02:30.170720 127.0.0.1 -> 127.0.0.1
CMP TTL:255 TOS:0xC0 ID:31185
TTL EXCEEDED
00 00 00 00 45 00 00 24 32 25 20 00 3B 06 2F AD  ....E..$2% .;./.
7F 00 00 01 7F 00 00 01 AA 1E 01 11 50 FE C6 45  ............P..E
00 00 00 00 50 02 08 00 41 41 41 41 41 41 41 41  ....P...AAAAAAAA
41 41 41 41 41 41 41 41 41 41 41 41              AAAAAAAAAAAA

Also - to prove this is not Snort's fault I included a tcpdump(3) log.

01:06:02.640246   lo < 127.0.0.1 > 127.0.0.1: icmp: ip reassembly time exceeded
[tos 0xc0]
                         45c0 0054 7b85 0000 ff01 4161 7f00 0001
                         7f00 0001 0b01 77a3 0000 0000 4500 0024
                         d3e5 2000 3306 95ec 7f00 0001 7f00 0001
                         c027 055a 5fa5 73a5 0000 0000 5002 0800
                         4141 4141 4141 4141 4141 4141 4141 4141

AFFECTED:

I assume it would be any OS that includes more than the ipaddresses/ports.
 
USAGES:

The ramifications from this could be great. You may get fragments of the 
shadow file, various plaintext passwords (greatly depends...), pieces of code,
urls, random memory.

One specific use is for this could be identifying the endianness of a remote 
machine because of the addresses are in memory. (Reading from Linux Magazine
November 2001, page 50, you have 0xef* for the stack on a big endian system as opposed to the 0xbf* on little endian. (linux-wise)).

FIX:

  hrmm.... well. 

  + Locking memory for important stuff (passwords etc.). I've forgotten the
      call to do that but it is possible. This will prevent swapping to disk
      which might make it better.

  + Modifying the kernel so in its idle loop (or whatever) it wipes some
    (unused!) memory. Could lead to a race though...

  + A small program to continues malloc()/zero/free() stuff. A little like the
      program above, but zeroing it instead. (You could always take the 
      offensive stand by filling it with decoy data... that's left to the
      reader to implement. ;)

  + Make the network code zero out the packet before sending it. This would
      slow it down though, and make it even more obvious that you are running
      linux. 

  + Filter out various icmp error messages, but as usual that breaks 
    everything.


(1). Nmap   http://www.insecure.org/nmap

(2). Snort  http://www.snort.org
     snort -vd -i lo

(3) tcpdump -lnx
Lawrence Berkeley National Laboratory
Network Research Group
tcpdump@ee.lbl.gov
ftp://ftp.ee.lbl.gov/tcpdump.tar.Z

(4) Make sure you visit Chapel of Stilled Voices
                       .  .  _  _   _  _ .  .     _  _  _ .  .
 |_  _|_ _|_  _ .  / / |\/| |_| _| |  | ||\/|  / |  | ||_ |  |
 | |  |   |  |_|. / /  |  | |   _|.|_ |_||  | /  |_ |_| _| \/ 
             |
(5) Hey, there is no [5], so why are you reading this!?@!



--
www.tasmail.com


----- End forwarded message -----

-- 
         Martin Maèok                 http://underground.cz/
   martin.macok@underground.cz        http://Xtrmntr.org/ORBman/
