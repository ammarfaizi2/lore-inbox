Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbVBXKYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbVBXKYH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 05:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVBXKWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 05:22:40 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:60890 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262164AbVBXKUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 05:20:46 -0500
Date: Thu, 24 Feb 2005 04:20:44 -0600
Message-Id: <200502240420.AA11797364@mack-one.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Leslie 'Mack' McBride   " <Mack@mack-one.com>
Reply-To: <Mack@mack-one.com>
To: <linux-kernel@vger.kernel.org>
Subject: Hanging on time out in CIFS
X-Mailer: <IMail v7.15>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There appears to be a problem with the CIFS VFS.
Under certain circumstances slow browsing appears
as hanging.  The cause is a stealthing firewall
on a Windows CIFS server.  The stealthing firewall
prevents outgoing TCP packets with the RST flag
set.  When a Windows 2003 server drops a CIFS
session it uses a RST instead of the customary
FIN to end a TCP connection.  The stealthing
firewall prevents RST packets from being sent.
 
This results in a process accessing the CIFS
share hanging until the TCP connection dies,
which takes approximately 15 minutes.  The
Linux CIFS continues attempting to access the
dead TCP channel until it expires.
 
Windows XP handles this in a somewhat more
graceful manner by opening a new TCP connection
if no response is received in 17 seconds.  This
results in a quite common result of "slow" browsing.
Various fixes have been tried but the stealthing
firewall appears to be a reasonably new
discovery as to the cause of this problem.
 
This problem of "slow" browsing has been around
since the release of windows 2000.  It is surprising
that the firewall connection hasn't been previously
commented on.  I am uncertain if Windows 2000
also sends a RST instead of a FIN to close the
connection but from the number of posts I suspect
that it also experiences this problem.
 
This problem may occur in other circumstances.
For example if a switch dies.  A multi-homed
server may still be accessible but the client
will attempt to continue accessing the original
TCP connection even though the connection and IP
effectively no longer exist.  Another example is a
distributed share.  If a single server dies the share
should still be accessible but the client will
continue attempting to access the dead server.
 
For other clients a dead connection isn't particularly
troublesome since it is possible to kill the client.
In this case the client cannot be killed because
it is in a wait state.  The kill is not registered
until the socket expires.  At that point the client
would have created a new connection and
completed.  So a kill is basically useless.
 
I have discussed this problem with S. French
at IBM and he suggested posting to see if anyone
has a work around that has been used to overcome
similar problems in other protocols.  Suggestions
should be forwarded to Mr. French since he is a
primary maintainer of the CIFS code.
 
Short term solutions to the problem include
1) Eliminating the stealthing function of the firewall
on the relevant ports (139 and 445) and interfaces.
2) Keeping an open file on the share.
3) Setting up a process to access the share periodically
(less than 15 minutes) to prevent a time out.
4) Setting the server to prevent idle time outs.
 
Security Settings/Local Policies/Security Options
Microsoft Network Server: Amount of idle time 
required before suspending session.
 
Default: 15 minutes
setting to 0 prevents idle time outs.
 
In my case I used option 1.
 
The 2003 RAS/NAT/Basic Firewall stealths all 
non-forwarded ports automatically on the public 
interface.
 
The stealing function was redundant since only
one port (20) was stealthed by the firewall on the
public interface.
 
The firewall I use does not allow independent
stealing of ports or interfaces so stealthing is
now completely disabled on the private interface
of the 2003 server.
 
Sincerely,
 
LR Mack McBride
