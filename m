Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262595AbSI0Vvf>; Fri, 27 Sep 2002 17:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262599AbSI0Vve>; Fri, 27 Sep 2002 17:51:34 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:13255 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S262595AbSI0Vvd>;
	Fri, 27 Sep 2002 17:51:33 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Generic HDLC interface continued
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 27 Sep 2002 23:45:05 +0200
Message-ID: <m3y99nrtsu.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just want to return to the generic HDLC ioctl interface issue.

Currently (in 2.5) we have:

struct ifreq 
{
  char ifrn_name[IFNAMSIZ];

  union {
    ...

    struct if_settings {
        unsigned int type;      /* Type of physical device or protocol */
        union {
            /* {atm/eth/dsl}_settings anyone ? */

            union hdlc_settings {
                raw_hdlc_proto          raw_hdlc;
                cisco_proto             cisco;
                fr_proto                fr;
                fr_proto_pvc            fr_pvc;
            }ifsu_hdlc;

            union line_settings {
                sync_serial_settings    sync;
                te1_settings            te1;
            }ifsu_line;
        } ifs_ifsu;

    } *ifru_settings;
  } ifr_ifru;
}

As the previous discussion showed, the ifs_ifsu union is just an
artificial structure - it's used only for the purpose of filling
the space in if_settings, as both sides (user and kernel) use
the members hdlc_settings or line_settings with their real length
(as opposed to the union length).

This situation creates some problems. First, IMHO the presence
of artificial union is a problem (one could think we're really using
the union and not variable length int type with *_proto / *_settings).

Second, the user-level utility has to supply the full length union
if it want to query the kernel (with IF_GET_PROTO etc) - as it doesn't
know what protocol has been set. It might not be a problem now, but
will be when a bigger member struct is added (imagine an ioctl setting
/getting a long encryption key etc).

Third, we are using complicated data types instead of simple flat ones,
which negatively affect code readability.


Solution:
struct ifreq 
{
    char ifrn_name[IFNAMSIZ];

    union ifr_ifru {
        ...
        struct {
            int type;
            int size;
            union {
                raw_hdlc_proto *;
                cisco_proto *;
                etc_proto *;
                sync_serial_settings *;
                etc_line_settings *;

Addressing the second problem (unknown data length) requires the caller
(user-space utils) to supply allocated space size. The kernel would
update the size to reflect the actual amount of data required, allowing
the caller to allocate more space and try again (or ignore the unknown
interface).

What is important here is that inner union consists of pointers
to *_proto / *_settings structs and not of the structs themselves.


Another solution - using a different ifreq structs for different tasks
(something like the sockaddr_*) - sort of:

struct ifreq_raw_hdlc_proto {
        char ifrn_name[IFNAMSIZ];
        int type;
        int size;
        raw_hdlc_proto settings;
};

struct ifreq_cisco_proto {
        char ifrn_name[IFNAMSIZ];
        int type;
        int size;
        raw_hdlc_proto settings;
};

The first 3 members would be common to all tasks (we would use a macro
for that, of course).


Comments?
-- 
Krzysztof Halasa
Network Administrator
