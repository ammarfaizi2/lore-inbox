Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261654AbSJJQS3>; Thu, 10 Oct 2002 12:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbSJJQS3>; Thu, 10 Oct 2002 12:18:29 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:62598 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP
	id <S261654AbSJJQSW>; Thu, 10 Oct 2002 12:18:22 -0400
Date: Thu, 10 Oct 2002 23:27:49 +0700
From: Pavel Selivanov <pavel-linux-kernel@parabel.inc.ru>
X-Mailer: The Bat! (v1.60) UNREG / CD5BF9353B3B7091
Reply-To: Pavel Selivanov <pavel-linux-kernel@parabel.inc.ru>
X-Priority: 3 (Normal)
Message-ID: <35278845015.20021010232749@parabel.inc.ru>
To: linux-kernel@vger.kernel.org
Subject: RE: Generic HDLC interface continued
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm using hdlc stack for a E1 adapter since Aug. 2001,
and I have some suggestions/questions:
1) I think that hdlc stack should know nothing about my interface type
(whether it's V.35, DSL, E1/T1, HPPI, ...).
 I'm sure that hdlc stack must provide only protocols support (and a
 configuration utility to configure protocol's parameters only).
 All other job is developer's problem (even crc type).

 While placing interface type in hdlc struct's isn't good,
 but to place it in net_device is a good idea (I think).

 Possible it's reasonable to make another utility like ethertool (called, for
 example, e1tool, mdsltool,...) and complementary header (ioctls, structs,...)
 for configuring interface(for E1: crc4, timeslots,
 ...), and getting stats.

 2) If I've understand author's ideology, he is going to implement
 hdlc stack "near" current network stack.
 I mean hdlc_device appends new fields to net_device, so hdlc device
 is still the same device as ethernet, and that's fine.

 I dont understant what is it for (for this ideology)?
 >>>>>>>>
 if.h
struct if_settings
{
        unsigned int type;      /* Type of physical device or protocol */
        union {
                /* {atm/eth/dsl}_settings anyone ? */
                union hdlc_settings ifsu_hdlc;
                union line_settings ifsu_line;
        } ifs_ifsu;
};  
.....
in struct ifreq
                struct  if_settings *ifru_settings;
 <<<<<<<<
Is it really necessary ?
At my opinion it would be better to use char *,
and to define it in hdlc.h, hdlc/ioctl.h

3)
>>>>>>>>>>>
/* For definitions see hdlc.h */
#define IF_IFACE_V35    0x1000          /* V.35 serial interface        */
#define IF_IFACE_V24    0x1001          /* V.24 serial interface        */
#define IF_IFACE_X21    0x1002          /* X.21 serial interface        */
#define IF_IFACE_T1     0x1003          /* T1 telco serial interface    */
#define IF_IFACE_E1     0x1004          /* E1 telco serial interface    */
#define IF_IFACE_SYNC_SERIAL 0x1005     /* cant'b be set by software    */

/* For definitions see hdlc.h */
#define IF_PROTO_HDLC   0x2000          /* raw HDLC protocol            */
#define IF_PROTO_PPP    0x2001          /* PPP protocol                 */
#define IF_PROTO_CISCO  0x2002          /* Cisco HDLC protocol          */
#define IF_PROTO_FR     0x2003          /* Frame Relay protocol         */
#define IF_PROTO_FR_ADD_PVC 0x2004      /*    Create FR PVC             */
#define IF_PROTO_FR_DEL_PVC 0x2005      /*    Delete FR PVC             */
#define IF_PROTO_X25    0x2006          /* X.25                         */
<<<<<<<<<<<

As I understand, it will be never able to make something like
ppp-over-framerelay...
But it is widely used, and (for example) negraph in xBSD provide's
such functionality...

4)
>>>>>>>>>>>
        union {
                struct {
                        fr_proto settings;
                        pvc_device *first_pvc;
                        int pvc_count;

                        struct timer_list timer;
                        int last_poll;
                        int reliable;
                        int changed;
                        int request;
                        int fullrep_sent;
                        u32 last_errors; /* last errors bit list */
                        u8 n391cnt;
                        u8 txseq; /* TX sequence number */
                        u8 rxseq; /* RX sequence number */
                }fr;

                struct {
                        cisco_proto settings;

                        struct timer_list timer;
                        int last_poll;
                        int up;
                        u32 txseq; /* TX sequence number */
                        u32 rxseq; /* RX sequence number */
                }cisco;

                struct {
                        raw_hdlc_proto settings;
                }raw_hdlc;

                struct {
                        struct ppp_device pppdev;
                        struct ppp_device *syncppp_ptr;
                        int (*old_change_mtu)(struct net_device *dev,
                                              int new_mtu);
                }ppp;
        }state; 
<<<<<<<<<<<<<<<

If someone will have to support one more protocol, he have to modify
hdlc.h (to add new struct in the union)...
Why don't we do like this:

struct hdlc_proto{
       attach
       detach
       rcv
       enslave
       void *priv; //Protocol's specific data
       char proto_type; //protocol (ppp, fr,...) in a chain
       struct proto *next;
};
struct hdlc_proto *proto_list;//Supported protocol's list.

typedef struct hdlc_device_struct {
....
    struct hdlc_proto *prot; //pointer to current protocol's struct
}

As long as sethdlc tell to hdlc stack: I want ppp-over-fr, hdlc to:
- search proto_list for ppp, search for fr.
- attaches ppp to prot pointer in hdlc_device
- calls fr->attach (which allocated priv pointer)
- calls ppp->attach (which allocates priv pointer)
- calls fr->enslave

This model seems bulki, but It's much more flexible (without changin
API, what is very important at my opinion.)

5) It's bad to handle get_stats by hdlc stack.
Some chips provides some info, which I shoud ask(for ifconfig)...

I think hdlc should care own statistics (specific for every
protocol).

It's very comfortable in cisco that I have full protocol's info
(broadcasts, protocol errors, ...).
Hdlc stack must take no care on HW errors, it's my problem, but it
must have it's own statistics.

Sorry for my criticism.
My opinion isn't obsolete, I'm sure I'm wrong in many cases :-)
I just want for hdlc stack in Linux to be as usefull as it's
possible, and to have a single API (HDLC API changing in second
time...).

If I've understant something incorrectle - please tell me.

PS: Sorry for my English.

