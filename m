Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131688AbQKCVKF>; Fri, 3 Nov 2000 16:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131405AbQKCVJy>; Fri, 3 Nov 2000 16:09:54 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:38057 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S131688AbQKCVJm>; Fri, 3 Nov 2000 16:09:42 -0500
Message-ID: <3A032986.BF0F89F7@linux.com>
Date: Fri, 03 Nov 2000 13:09:27 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christopher Friesen <cfriesen@nortelnetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: how to get IP address of current machine from C++ code?
In-Reply-To: <200010210246.WAA08580@smarty.smart.net> <3A02F7C4.E140D608@nortelnetworks.com>
Content-Type: multipart/mixed;
 boundary="------------4A731C833506158A81F2C2ED"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4A731C833506158A81F2C2ED
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Christopher Friesen wrote:

> I would like to get the IP address of one of the interfaces of the
> machine that I'm currently on from within some C++ code.  It looks like
> I should be able to do this by doing an
>
> ioctl(atoi(fd, SIOCGIFADDR, &ifr)
>
> with the interface name set in the appropriate field in ifr, but I'm not
> sure how I should be getting the proper value for fd.  I would
> appreciate some help on this, or if there is a better way then I'd love
> to hear it.

This isn't c++, it's plain c, but it's easy to grok.  Called as: gi
[interface]

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------4A731C833506158A81F2C2ED
Content-Type: text/plain; charset=us-ascii;
 name="gi.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gi.c"

/*
 * short hack to grab interface information
 * gcc -o gi gi.c; strip gi
 *
 * Blu3, Jan 1999
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define SIOCGIFCONF        0x8912          /* get iface list               */

int main(int argc, char *argv[])
{
int numreqs = 30, sd, n, search, tick, found=0;
struct ifconf ifc;
struct ifreq *ifr;
struct in_addr *ia;

//
// if there is an arg on the command line, print out the ip of that device
// only.  note the numreqs in the above, modify that as is desired.

search= (argc>1);
if(search && strlen(argv[1]) > 64) {
  fprintf(stderr, "specified device name too large, ignoring\n");
  search=0;
}

sd=socket(AF_INET, SOCK_STREAM, 0);
ifc.ifc_buf = NULL;
ifc.ifc_len = sizeof(struct ifreq) * numreqs;
ifc.ifc_buf = realloc(ifc.ifc_buf, ifc.ifc_len);
if (ioctl(sd, SIOCGIFCONF, &ifc) < 0) {
	perror("SIOCGIFCONF");
}
                                 
ifr = ifc.ifc_req;
for (n = 0; n < ifc.ifc_len; n += sizeof(struct ifreq)) {
	ia= (struct in_addr *) ((ifr->ifr_ifru.ifru_addr.sa_data)+2);
	if(search)
		tick= strcmp(ifr->ifr_ifrn.ifrn_name, argv[1]);

	if(!search)
		fprintf(stdout, "%6s %-15s\n", ifr->ifr_ifrn.ifrn_name, inet_ntoa(*ia));
	  
	if (search && (tick==0)) {
		fprintf(stdout, "%s\n", inet_ntoa(*ia));
		found=1;
	}
	ifr++;
}

free(ifc.ifc_buf);
fprintf(stderr, "exiting with %i\n", found);
exit(found);
}

--------------4A731C833506158A81F2C2ED
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
org:<img src="http://www.kalifornia.com/images/paradise.jpg">
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;-12480
fn:David Ford
end:vcard

--------------4A731C833506158A81F2C2ED--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
