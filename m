Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137025AbRAHGFE>; Mon, 8 Jan 2001 01:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137024AbRAHGE7>; Mon, 8 Jan 2001 01:04:59 -0500
Received: from james.kalifornia.com ([208.179.0.2]:13691 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S136929AbRAHGEq>; Mon, 8 Jan 2001 01:04:46 -0500
Date: Sun, 7 Jan 2001 22:04:43 -0800 (PST)
From: David Ford <david@linux.com>
To: linux-kernel@vger.kernel.org
Subject: Broken tty handling
Message-ID: <Pine.LNX.4.10.10101072145070.12242-100000@Huntington-Beach.Blue-Labs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every once in a while I have a very frustrating problem develop.  All tty
handling stops.  Packets flow in and out of the machine fine, but anything
with a tty halts.  I don't know exactly what is happening but I have found
that killing the last user that logged in (all his processes) usually fixes
everything.

It just happened to me and I realize this is vague but there's nothing I
have been able to attribute it to other than a problem in tty handling.  I
know it isn't ssh v.s. telnet v.s. xyz because it doesn't matter, they all
stall.

Here's the data I had.  Aaron was the last person to log in when it broke, I
was the first after it broke.

# grep aaron brokettyspseo
aaron    22843 do_adj -bash
aaron    22865 write_ pine
aaron    23211 do_adj -bash
aaron    23228 tty_wa stty icanon echo
aaron    23277 read_c -bash

# w|grep aaron
.aaron    pts/13  dur-cas1-cs-26.d  9:12pm 26:44   0.14s  0.10s  pine 
.aaron    pts/14  dur-cas1-cs-26.d  9:28pm 15:09   0.01s  0.01s  -bash 
.aaron    pts/15  dur-cas1-cs-26.d  9:29pm 14:26   0.06s  0.06s  -bash 

An 'skill aaron' didn't solve it but 'skill -9 aaron' did.

Here's a snippet from my /etc/profile which the stty from above comes into
play:

# does the user want his titlebar set?
if [ "x$TITLEBAR" = "xyes" ]; then
  echo -ne Checking for titlebar capability
  stty -icanon -echo min 0 time 20
  echo -ne '\033[7n'
  read term_id
  display=$(echo $term_id|sed '/.*:0/!d')
  if [ x$display != x ]; then
    PS1='\[\033]2; ($(date +%l:%M%p)) \u@\h \w\007\033]1;\u@\h\007\]\$ '
  else
    PS1='\h:\w\$ '
  fi
  echo -ne '\033[2K\r'
  stty icanon echo
else
  PS1='\h:\w\$ '
fi


# uname -r
2.4.0-test11

# sed '/C [lL]ibrary /!d; s/[^0-9]*\([0-9.]*\).*/\1/' /lib/libc.so.6
2.1.3

# mount|grep pts
none on /dev/pts type devpts (rw,gid=5,mode=640)


Any suggestions?  Should this be addressed elsewhere?  The reason I bring it
up here is because ALL ttys halt except those on the console.

-d

--
---NOTICE--- fwd: fwd: fwd: type emails will be deleted automatically.
      "There is a natural aristocracy among men. The grounds of this are
      virtue and talents", Thomas Jefferson [1742-1826], 3rd US President

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
