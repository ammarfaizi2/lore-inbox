Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264199AbTKUDOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 22:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbTKUDOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 22:14:30 -0500
Received: from palrel10.hp.com ([156.153.255.245]:62424 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264199AbTKUDOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 22:14:01 -0500
Date: Thu, 20 Nov 2003 19:13:59 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] All my Pcmcia cards are 'eth0'
Message-ID: <20031121031359.GA19405@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Hi,

	I've got a pile of Pcmcia wireless cards. I'm trying to make
them work with hotplug (currently using the old Pcmcia scripts).

	One of the main problem is that they are all assigned 'eth0',
and therefore all configured with the same IP address. This is really
pathetic.

	The usual answer is : you should use 'nameif' :
http://www.xenotime.net/linux/doc/network-interface-names.txt
	Well, of course, nobody ever bothered to try it, so it doesn't
work. No comments.

	To make it work you will need :
	1) The attached "improved" version of nameif
	2) Modify /etc/hotplug/net.agent with the following code :
---------------------------------------
	    # Run nameif as needed - Jean II
	    # Remap interface names based on MAC address. This workaround
	    # the dreaded configuration problem "all my cards are 'eth0'"...
	    if [ -e /etc/mactab ]; then
		debug_mesg invoke nameif -i $INTERFACE
		NEWNAME=`/usr/local/bin/nameif -i $INTERFACE`
		if [ -n "$NEWNAME" ]; then
		    debug_mesg iface $INTERFACE is remapped to $NEWNAME
		    INTERFACE=$NEWNAME
		fi;
	    fi
---------------------------------------

	Note that this is currently very rough and "works for me". In
particular, I bet that the code above doesn't process error from
nameif properly. I'm sure someone more knowlegeable in shell scripts
will straighten all that.

	Have fun...

	Jean

P.S. : Now, I just need to figure out how to implement schemes...

--gKMricLos+KVdGMg
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="nameif.c"

/* 
 * Name Interfaces based on MAC address.
 * Writen 2000 by Andi Kleen.
 * Subject to the Gnu Public License, version 2.  
 * TODO: make it support token ring etc.
 * $Id: nameif.c,v 1.3 2003/03/06 23:26:52 ecki Exp $
 */ 
#ifndef _GNU_SOURCE 
#define _GNU_SOURCE
#endif
#include <stdio.h>
#include <getopt.h>
#include <sys/syslog.h>
#include <errno.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <stdarg.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <linux/sockios.h>
#include <errno.h>
#include "intl.h" 

const char default_conf[] = "/etc/mactab"; 
const char *fname = default_conf; 
int use_syslog; 
int ctl_sk = -1; 

void err(char *msg) 
{ 
	if (use_syslog) { 
		syslog(LOG_ERR,"%s: %m", msg); 
	} else { 
		perror(msg); 
	} 
	exit(1); 
}

void complain(char *fmt, ...) 
{ 
	va_list ap;
	va_start(ap,fmt);
	if (use_syslog) { 
		vsyslog(LOG_ERR,fmt,ap);
	} else {
		vfprintf(stderr,fmt,ap);
		fputc('\n',stderr); 
	}
	va_end(ap); 
	exit(1);
} 

void warning(char *fmt, ...) 
{ 
	va_list ap;
	va_start(ap,fmt);
	if (use_syslog) { 
		vsyslog(LOG_ERR,fmt,ap);
	} else {
		vfprintf(stderr,fmt,ap);
		fputc('\n',stderr); 
	}
	va_end(ap); 
} 

/*
 * Extract a MAC address out of the config file.
 * We now accept wildcards in MAC addresses, either '*' or 'XX'.
 * Also avoid 'mac' overrun ;-)
 * Jean II
 */
int parsemac(char *str, unsigned short *mac)
{ 
	char *s;
	int i = 0;
	while (((s = strsep(&str, ":")) != NULL) && (i < 6)) { 
		unsigned byte;
		if (!strcmp(s, "*") || !strcmp(s, "XX"))
			/* Wildcard */
			byte = 0x100;
		else
			/* Standard hex digits */
			if (sscanf(s,"%x", &byte) != 1 || byte > 0xff) 
				return -1;
		mac[i++] = byte;
	}
	return 0;
} 

/*
 * Compare a mac address to a mac filter - Jean II
 * With wilcards, the most generic wildcard must come first,
 * and the most specific last. This is because the linked list is
 * built by inserting later entries in front. Jean II
 */
int matchmac(unsigned short *match, unsigned char *mac)
{
	int i;
	int same = 1;
	for(i = 0; i < 6; i++) {
		if((match[i] != 0x100) && (match[i] != mac[i]))
			same = 0;
	}
	return same;
}

void *xmalloc(unsigned sz)
{ 
	void *p = calloc(sz,1);
	if (!p) errno=ENOMEM, err("xmalloc"); 
	return p; 
} 

void opensock(void)
{
	if (ctl_sk < 0) 
		ctl_sk = socket(PF_INET,SOCK_DGRAM,0); 
}

#ifndef ifr_newname
#define ifr_newname ifr_ifru.ifru_slave
#endif

int  setname(char *oldname, char *newname)
{
	struct ifreq ifr;
	opensock(); 
	memset(&ifr,0,sizeof(struct ifreq));
	strcpy(ifr.ifr_name, oldname); 
	strcpy(ifr.ifr_newname, newname); 
	return ioctl(ctl_sk, SIOCSIFNAME, &ifr);
}

int getmac(char *name, unsigned char *mac)
{
	int r;
	struct ifreq ifr;
	opensock(); 
	memset(&ifr,0,sizeof(struct ifreq));
	strncpy(ifr.ifr_name, name, IFNAMSIZ); 
	r = ioctl(ctl_sk, SIOCGIFHWADDR, &ifr);
	memcpy(mac, ifr.ifr_hwaddr.sa_data, 6); 
	return r; 
}

struct change { 
	struct change *next;
	int found;
	char ifname[IFNAMSIZ+1];
	unsigned short mac[6];
}; 
struct change *clist;

struct change *lookupmac(unsigned char *mac) 
{ 
	struct change *ch;
	for (ch = clist;ch;ch = ch->next) 
		if (matchmac(ch->mac, mac))
			return ch;
	return NULL; 
} 

int addchange(char *p, struct change *ch, char *pos)
{
	if (strchr(ch->ifname, ':'))
		warning(_("alias device %s at %s probably has no mac"), 
			ch->ifname, pos); 
	if (parsemac(p,ch->mac) < 0) 
		complain(_("cannot parse MAC `%s' at %s"), p, pos); 
	ch->next = clist;
	clist = ch;
	return 0; 
}

void readconf(void)
{
	char *line; 
	size_t linel; 
	int linenum; 
	FILE *ifh;
	char *p;
	int n;

	ifh = fopen(fname, "r");
	if (!ifh) 
		complain(_("opening configuration file %s: %s"),fname,strerror(errno)); 

	line = NULL; 
	linel = 0;
	linenum = 1; 
	while (getdelim(&line, &linel, '\n', ifh) > 0) {
		struct change *ch = xmalloc(sizeof(struct change)); 
		char pos[20]; 

		sprintf(pos, _("line %d"), linenum); 

		if ((p = strchr(line,'#')) != NULL)
			*p = '\0';
		p = line; 
		while (isspace(*p))
			++p; 
		if (*p == '\0')
			continue; 
		n = strcspn(p, " \t"); 
		if (n > IFNAMSIZ) 
			complain(_("interface name too long at line %d"), line);  
		memcpy(ch->ifname, p, n); 
		ch->ifname[n] = 0; 
		p += n; 
		p += strspn(p, " \t"); 
		n = strspn(p, "0123456789ABCDEFabcdef:*X"); 
		p[n] = 0; 
		addchange(p, ch, pos);
		linenum++;
	}   
	fclose(ifh); 
}

/*
 * Boot time processing.
 * Process all network interface present on the system.
 * Jean II
 */
void processiflist(void)
{
	FILE *ifh; 
	char *p;
	int n;
	int linenum; 
	char *line = NULL;
	size_t linel = 0;

	ifh = fopen("/proc/net/dev", "r"); 
	if (!ifh)  complain(_("open of /proc/net/dev: %s"), strerror(errno)); 


	linenum = 0;
	while (getdelim(&line, &linel, '\n', ifh) > 0) {
		struct change *ch; 
		unsigned char mac[6];

		if (linenum++ < 2) 
			continue;
			
		p = line; 
		while (isspace(*p)) 
			++p;
		n = strcspn(p, ": \t");  
		p[n] = 0; 
		
		if (n > IFNAMSIZ-1) 
			complain(_("interface name `%s' too long"), p); 
			
		if (getmac(p, mac) < 0) 
			continue;
			
		ch = lookupmac(mac); 
		if (!ch) 
			continue;
		
		ch->found = 1;	
		if (strcmp(p, ch->ifname)) { 
			if (setname(p, ch->ifname) < 0)  
				complain(_("cannot change name of %s to %s: %s"),
						p, ch->ifname, strerror(errno)); 
		} 
	} 
	fclose(ifh); 
	
	while (clist) { 
		struct change *ch = clist;
		clist = clist->next;
		if (!ch->found)
			warning(_("interface '%s' not found"), ch->ifname); 
		free(ch); 
	}
}

/*
 * HotPlug processing.
 * Process the new network interface found by hotplug.
 * Jean II
 */
void processifname(char *ifname)
{
	struct change *ch; 
	unsigned char mac[6];

	if (getmac(ifname, mac) < 0) 
		return;

	ch = lookupmac(mac); 
	if (!ch) 
		return;

	if (strcmp(ifname, ch->ifname)) { 
		if (setname(ifname, ch->ifname) < 0)
			complain(_("cannot change name of %s to %s: %s"),
					ifname, ch->ifname, strerror(errno)); 
	}

	/* Always print out the *new* interface name so that
	 * the calling script can pick it up. Jean II */
	printf("%s\n", ch->ifname);
}

struct option lopt[] = { 
	{"syslog", 0, NULL, 's' },
	{"config-file", 1, NULL, 'c' },
	{"help", 0, NULL, '?' }, 
	{NULL}, 
}; 

void usage(void)
{
	fprintf(stderr, _("usage: nameif [-c configurationfile] [-i ifname] [-s] {ifname macaddress}\n")); 
	exit(1); 
}

int main(int ac, char **av) 
{
	char *ifname = NULL;

	for (;;) {
		int c = getopt_long(ac,av,"c:i:s",lopt,NULL);
		if (c == -1) break;
		switch (c) { 
		default:
		case '?':
			usage(); 
		case 'c':
			fname = optarg;
			break;
		case 'i':
			ifname = optarg;
			break;
		case 's':
			use_syslog = 1;
			break;
		}
	}

	if (use_syslog) 
		openlog("nameif",0,LOG_LOCAL0);
		
	while (optind < ac) { 
		struct change *ch = xmalloc(sizeof(struct change)); 
		char pos[30];

		if ((ac-optind) & 1) 
			usage();
		if (strlen(av[optind])+1>IFNAMSIZ) 
			complain(_("interface name `%s' too long"), av[optind]);
		strcpy(ch->ifname, av[optind]); 
		optind++; 
		sprintf(pos,_("argument %d"),optind); 
		addchange(av[optind], ch, pos); 
		optind++; 
	} 

	if (!clist || fname != default_conf) 
		readconf(); 

	/* Check if interface name was specified */
	if (ifname) {
		processifname(ifname);
	} else {
		processiflist();
	}

	if (use_syslog)
		closelog();
	return 0;
} 


--gKMricLos+KVdGMg--
