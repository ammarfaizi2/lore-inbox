Return-Path: <linux-kernel-owner+w=401wt.eu-S1752104AbWLSNzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbWLSNzy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 08:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbWLSNzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 08:55:54 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:56825 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbWLSNzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 08:55:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type;
        b=tLGDpJqVemTTd0t40tuciJqgH8b0K478gkw/pJTi2Lq7XYLNmAMztjpUhkHrVAulr4XcI5+KijdVljlZzY7U5+Q4h4zEp9cLTqLyd7gVqm4ljK5milOludp20AolH4ZNF0pikn7sokXTbhqVn6AbuRuUq1PXOa+Ia2AMttJXTXk=
Date: Tue, 19 Dec 2006 14:56:27 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Marek Wawrzyczny <marekw1977@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
Message-Id: <20061219145627.fabf3d98.diegocg@gmail.com>
In-Reply-To: <200612192357.45443.marekw1977@yahoo.com.au>
References: <MDEHLPKNGKAHNMBLJOLKCEAPAGAC.davids@webmaster.com>
	<Pine.LNX.4.62.0612171109180.27120@pademelon.sonytel.be>
	<200612192357.45443.marekw1977@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__19_Dec_2006_14_56_27_+0100_ZwKY99augaatjwyb"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__19_Dec_2006_14_56_27_+0100_ZwKY99augaatjwyb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El Tue, 19 Dec 2006 23:57:45 +1100, Marek Wawrzyczny <marekw1977@yahoo.com.=
au> escribi=F3:

> I had another, probably crazy idea. Would it be possible to utilize the=20
> current vendor/device PCI ID database to create Linux friendliness matrix=
=20
> site?

I've a script (attached) that looks into /lib/modules/`uname -r`/modules.pc=
imap,
looks up the IDs in the pci id database and print the real name. At least i=
t shows=20
it's possible to know what devices are supported ...




--Multipart=_Tue__19_Dec_2006_14_56_27_+0100_ZwKY99augaatjwyb
Content-Type: text/x-python;
 name="list-kernel-hardware.py"
Content-Disposition: attachment;
 filename="list-kernel-hardware.py"
Content-Transfer-Encoding: 7bit

#!/usr/bin/python

def pciids_to_names(ids):
	# Only the last four numbers of the ids have useful info
	vendorid = ids[1][6:10]
	deviceid = ids[2][6:10]
	subvendorid = ids[3][6:10]
	subdeviceid = ids[4][6:10]

	result = [ids[0], "", "", "", "", ""]
	pciids = open('/usr/share/misc/pci.ids', 'r')

	# Search for vendor
	for line in pciids:
		if line[0] == "#" or line[0] == "C" or line[0] == "\t":
			continue
		if line[0:4] == vendorid:
			result[1] = line[6:].strip() # Vendor name
			break

	if result[1] == "": # Vendor not found
		return result

	# Search for a device
	for line in pciids:
		if line[0] != "\t":
			continue
		if line[1:5] == deviceid:
			result[2] = line[7:].strip() # Device name
			break

	# Search a subsystem name
	for line in pciids:
		if line[2:11] == subvendorid + " " + subdeviceid: # subsystem name
			result[3] = line[12:].strip() # The subvendor and subdevice ids point to a _single_ subsystem name
			break

	# Search a class name
	if ids[5][4:6] == "00" and ids[5][6:8] == "00" and ids[5][6:8] == "00":
		pass # void class ids
	else:
		pciids.seek(0)
		# Search a class name
		for line in pciids:
			if line[0] == "C":
				if line[2:4] ==  ids[5][4:6]: # found class
					result[4] = line[6:].strip() # appended class name
					break

		if result[4] == "": # class not found
			return result

		# Search subclass name
		for line in pciids:
			if line [1:3] == ids[5][6:8]:
				result[5] = line[5:].strip()
				break
	return result




### Start of the code flow ###
import platform
pcimap = open('/lib/modules/' + platform.uname()[2] + '/modules.pcimap', 'r')
previousmodule = "" 
for line in pcimap:
	if line[0] == "#" or line[0] == " ": continue
	data = line.split(None)
	ret = pciids_to_names(data)

	if ret[0] != previousmodule: 
		previousmodule = ret[0]
		print "Driver: " + previousmodule

	if ret[2] == "":
		output = "\tDevice NOT found in the pciid database: " + repr(data)
	else:
		output = "\tDevice: " + ret[2] + " (deviceid " + data[2][6:] + "); made by " + ret[1] + " (vendorid " + data[1][6:] + ")"
		if ret[3] != "": output += "; Subsystem: " + ret[3] + " (subsysid " + data[3][6:] + ":" + data[4][6:] + ")"
		if ret[4] != "": output += "; Class: " + ret[4]
		if ret[5] != "": output += "; Subclass: " + ret[5] 

	print output

--Multipart=_Tue__19_Dec_2006_14_56_27_+0100_ZwKY99augaatjwyb--
