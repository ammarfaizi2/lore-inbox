Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267555AbUJRWZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267555AbUJRWZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUJRWZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:25:26 -0400
Received: from mail.inter-page.com ([12.5.23.93]:9222 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S267555AbUJRWZT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:25:19 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Willy Tarreau'" <willy@w.ods.org>
Cc: "'David S. Miller'" <davem@davemloft.net>,
       "'Olivier Galibert'" <galibert@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Mon, 18 Oct 2004 15:25:10 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAA0g7rRE8zJEWZlhn/X11k1gEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20041016102433.GA17984@alpha.home.local>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I was thinking in the generic case of "a protocol read() after select()" and
not specifically a UDP read() after select(); as any semantic chosen needs to be
generic.  That may be out of scope for your considerations.

If you allow for zero-length packets on the transport, then you are introducing a
semantic entity to silently displace a procedural entity [e.g. if your messaging
scheme allows for zero-length packets and you have the kernel "fake" a zero-length
packet, then the kernel is triggering semantics instead of and error recognition
process; if zero-length packets are impossible, then the kernel is creating a "new"
return condition with unforeseen consequences in all existing code.]

If your process is *not* prepared to deal with a zero-length return from a receive
message, then you will get a semantic error. [e.g. you "know" that all the packets
you receive have a certain structure, but here you are "receiving" a non-error even
that is outside of your semantic set and so not allowed-for in your existing state.
Etc.]

For every other file handle zero-length read is end of file.  So there is this "well
established" semantic meaning for "if ( 0 == read(fd,...))" and you are proposing to
non-trivially create a one-off for the specific case of fd==UDP-socket.  So now if
you pass this file handle through a generic mechanism then you break the generic
semantics by creating a "different class of files" where a state problem leads to the
generation of an "in-band, originless, valid receive event" that is completely
dissimilar to the expected meaning of the return value from a standard function call.

Basically, if it is possible to send and receive a zero-length message in a
connectionless protocol, you are _stealing_ the possible semantic meaning of that
message and retroactively claiming it as a signal from the kernel to the program.  IF
it isn't already possible to send and receive a zero-length message in that
connectionless transport, then you are adding a semantic that all the existing code
may be completely unable to interpret, or which may "trick" applications into
deciding they are getting the end-of-file condition because they don't know or care
that the transport in question is UDP.

So if you have a generic handling mechanism, centered on select(), that "knows" that
if it sees 0==read(...) then it should close the file handle, and if that mechanism
is given sockets conforming to this proposed modification, then that mechanism will
break.

[I *am* out of my depth about whether UDP allows zero-length messages, it has never
come up for me, but I don't think it matters.  If it isn't UDP legal, then you are
adding semantic.  If it is legal, then you are overloading known semantic.  Both
actions are surprising, so both are wrong.]

So returning zero from a read function on a file descriptor that "can not"
meaningfully know end-of-file (because it doesn't FIN etc) is still a very bad idea
because of the odd-out cases where it will have "impossible" or at least wildly
incorrect semantic consequences.

Not a good space to be mucking around in.

But that's just my opinion.  And I am now rambling...  8-)

Rob White.


-----Original Message-----
From: Willy Tarreau [mailto:willy@w.ods.org] 
Sent: Saturday, October 16, 2004 3:25 AM
To: Robert White
Cc: 'David S. Miller'; 'Olivier Galibert'; linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?

On Fri, Oct 15, 2004 at 03:42:55PM -0700, Robert White wrote:
> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]
> On Behalf Of Willy Tarreau
> 
> > As I asked in a previous mail in this overly long thread, why not returning
> > zero bytes at all. It is perfectly valid to receive an UDP packet with 0
> 
> Zero bytes is "end of file".  Don't go trying to co-opt end of file.  That way lies
> madness and despair.

Please explain me what "end of file" means with UDP. If your UDP-based app
expects to receive a zero when the other end stops transmitting, then it
might wait for a very long time. As opposed to TCP, there's no FIN control
flag to tell the remote host that you sent your last packet.

Willy

