Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVAYVxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVAYVxA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVAYVvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:51:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51666 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262170AbVAYVrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:47:53 -0500
Date: Tue, 25 Jan 2005 16:47:50 -0500 (EST)
From: Dan Williams <dcbw@redhat.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
cc: jgarzik@pobox.com
Subject: Where Linux 802.11x support needs work
Message-ID: <Pine.LNX.4.58.0501251630280.30850@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279707962-1485467196-1106689670=:30850"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279707962-1485467196-1106689670=:30850
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

This list of stuff that should get fixed in Linux wireless grew out of my 
attempt to put a GUI on top of Linux wireless with NetworkManager 
(http://people.redhat.com/dcbw/NetworkManager).  This isn't, of course, a 
demand or anything, and I've been personally slowly fixing stuff up as I 
come to it (orinoco merge, fixing linux-wlan-ng, small kernel wireless 
driver patches), but I don't think anyone has posted a comprehensive list 
of where Linux wireless currently falls a bit short.

I think the biggest issue here is that the Wireless Extensions API has 
stagnated a bit, and driver writers have gone off and done their own thing 
(for example, WPA support) because the WEAPI hasn't shown leadership in 
this area.  That's fixable, and at this point doesn't seem to be a large 
amount of work since the main offender here is only WPA.

Second, there are, for historical reasons most likely, areas where the 
WEAPI has multiple methods of encoding data to/from user space.  For 
example, WE Quality values and WE Frequency/Channel values.  Quality is 
either signed or unsigned 8-bit number, which (I believe) is either a raw 
dBm/rssi value or a percentage value, respectively.  Frequency uses 
exponent & mantissa notation, OR a channel # stuffed into the 
exponent/mantissa structure.  Things like that.

Comments appreciated, and hopefully this may spark some wider effort to 
get a few things fixed.

So without further ado, here's the list:
-------------------------------------------------------------------------

o  Quality values vary wildly or are absent
   1) atmel doesn't return any quality data from scanned APs
   2) ipw_2100 doesn't return _any_ quality data (as of v1.02)
   3) Different quality methods for almost every driver
      - Prism54 does a quality as a percentage
      - airo mixes use of absolute and relative values in dBm
      - Average and max quality levels for almost all drivers are
         artificial and don't come from the the card in any way

Work Item: normalize quality values.  Wireless extensions supports two
different types of quality data, either percentage or dBm.  PICK ONE.  I 
would recommend reporting only a Percentage value to user space with the 
SIOCGIWSTATS call, and having separate ioctl() calls for getting 
specific dBm/noise values if user-space applications _and_ the driver 
supports it.  We cannot have user-space applications guessing which of 3 
different quality algorithms the driver is reporting.

o  Frequency values vary wildly from iw_get_range
   1) prism54 uses completely different exponent values than airo
   2) airo, atmel, orinoco are the same

Work Item: Normalize frequency values between wireless cards.  Use 
actual frequencies in MHz rather than using Exponent & Mantissa format 
as now.  Force user-space applications to convert channels->frequencies, 
based on what frequencies the driver says it supports. Or, fix drivers 
to report Frequency<->Channel pairs when they report their supported 
frequencies, but the point again is to PICK ONE and make all drivers do 
that.  Remove the guessing-game from user-space and pick one API for 
drivers to use.

o  airo/prism54 seem to have problems with ip6 and cause panic
   1) Some drivers don't NULL out their data after they are done with
      it, causing kernel panics later on down the line.  See Red Hat
      bugzilla #135432 for details, Dave Jones has a patch for the airo
      driver that seems to work better, which is in Red Hat 2.6.10
      kernels.

Work Item: Make sure all drivers dispose of and NULL out their data when 
they close, or fix kernel areas that might depend on that stale data.  
Or whatever the problem is.

o  Not all drivers have correct netlink support, if they even have it
   1) orinoco is too twitchy, sends too many events (shouldn't send them
		during a scan for example)
   2) atmel, airo, and others don't seem to have any netlink support

Work Item: fix all drivers to ensure that when the card successfully 
associates with an access point, that it signals the kernel that its 
network link is "up".

o  Not all drivers support wirless scanning
   1) orinoco driver mainly, support is upstream and is being slowly
      merged into the kernel driver

Work Item: Speed up merge of upstream Orinoco into kernel orinoco

o  Firmware issues
   1) Cisco aironet firmware upload is quite inconsistent, fails with
      5.21 for example.  Firmware <= 5.02 seems to be required for using
      WEP with most access points.  Latest Cisco-provided driver is quite
      different than latest in-kernel driver

Work Item: Figure out licensing issues between Cisco-provided driver for 
2.4 kernel (which is MPL) and in-kernel airo driver (which is GPL).  
Then, figure out what changes were made to the Cisco-provided driver to 
support firmware up to 5.30.17, and make those changes in the in-kernel 
airo driver.

o  Ethtool support for all drivers
   1) viro has done a lot of them, not sure if this is complete.

o  Ad-Hoc mode support is quite flaky or absent from most drivers
   1) prism54 "mgmt tx queue full" errors on otherwise-working cards
   2) madwifi resets bitrate to 0 when switching to ad-hoc mode

Work Item: Fix drivers to support Ad-Hoc mode, attempt to get specs on 
their hardware & registers from manufacturers if we don't have that 
information yet for all "modern" cards.

o  WPA support is lacking or just in-progress, needs much help
   1) The point here is that Wireless Extensions API has severely lagged
      behind the capabilities of current chipsets.  There should be
      support _in_ Wireless Extensions for WPA and its associated
      technologies, instead of what all the drivers do now, which is
      separate, non-standard, private ioctl() calls for WPA settings.

Work Item: standardize on an interface for WPA and its associated 
technologies, and implement that interface in Wireless Extensions API.  
Fix all drivers to use that API rather than private ioctl() calls.  Some 
drivers that support WPA:  atmel, madwifi, prism54, ipw2200.  It would 
also be beneficial in this effort to support the calls that 802.1x 
stacks need (like wpa_supplicant and Open 802.1x) so that they don't 
have to patch the drivers (Open 802.1x) or create special per-driver 
hook modules (wpa_supplicant) to be able to capture the necessary 
authentication packets or set up the card's WPA settings.

o  Drivers deal with hidden ESSIDs differently
   1) ipw2x00 traps " " and runs of \0 and changes it to "<hidden>" in
      the driver, while other drivers just pass the blank string through

Work Item: Standardize all drivers to simply pass an empty string 
through to user-space when the base station does not broadcast its 
ESSID.  Drivers should _not_ be clever about this.


Levels of Importance (my opinion):
1) All drivers _MUST_ support wireless scanning (*cough* orinoco *cough*)
2) WPA support needs to be standardized in Wireless Extensions
3) Consistent (and present) quality data among drivers, both for
    currently connected AP and for scanned APs
4) rtnetlink link notification for all drivers when they associate with
    an AP
5) Ad-Hoc mode support
6) Ethtool support
7) Cisco firmware issues


--279707962-1485467196-1106689670=:30850
Content-Type: TEXT/plain; charset=US-ASCII; name="linux-wireless-problems.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0501251647500.30850@devserv.devel.redhat.com>
Content-Description: 
Content-Disposition: attachment; filename="linux-wireless-problems.txt"

V2hhdCBuZWVkcyB0byBiZSBmaXhlZCBpbiBMaW51eCA4MDIuMTF4IFdpcmVs
ZXNzOg0KDQpvICBRdWFsaXR5IHZhbHVlcyB2YXJ5IHdpbGRseSBvciBhcmUg
YWJzZW50DQogICAxKSBhdG1lbCBkb2Vzbid0IHJldHVybiBhbnkgcXVhbGl0
eSBkYXRhIGZyb20gc2Nhbm5lZCBBUHMNCiAgIDIpIGlwd18yMTAwIGRvZXNu
J3QgcmV0dXJuIF9hbnlfIHF1YWxpdHkgZGF0YSAoYXMgb2YgdjEuMDIpDQog
ICAzKSBEaWZmZXJlbnQgcXVhbGl0eSBtZXRob2RzIGZvciBhbG1vc3QgZXZl
cnkgZHJpdmVyDQogICAgICAtIFByaXNtNTQgZG9lcyBhIHF1YWxpdHkgYXMg
YSBwZXJjZW50YWdlDQogICAgICAtIGFpcm8gbWl4ZXMgdXNlIG9mIGFic29s
dXRlIGFuZCByZWxhdGl2ZSB2YWx1ZXMgaW4gZEJtDQogICAgICAtIEF2ZXJh
Z2UgYW5kIG1heCBxdWFsaXR5IGxldmVscyBmb3IgYWxtb3N0IGFsbCBkcml2
ZXJzIGFyZQ0KICAgICAgICAgYXJ0aWZpY2lhbCBhbmQgZG9uJ3QgY29tZSBm
cm9tIHRoZSB0aGUgY2FyZCBpbiBhbnkgd2F5DQoNCldvcmsgSXRlbTogbm9y
bWFsaXplIHF1YWxpdHkgdmFsdWVzLiAgV2lyZWxlc3MgZXh0ZW5zaW9ucyBz
dXBwb3J0cyB0d28NCmRpZmZlcmVudCB0eXBlcyBvZiBxdWFsaXR5IGRhdGEs
IGVpdGhlciBwZXJjZW50YWdlIG9yIGRCbS4gIFBJQ0sgT05FLiAgSSANCndv
dWxkIHJlY29tbWVuZCByZXBvcnRpbmcgb25seSBhIFBlcmNlbnRhZ2UgdmFs
dWUgdG8gdXNlciBzcGFjZSB3aXRoIHRoZSANClNJT0NHSVdTVEFUUyBjYWxs
LCBhbmQgaGF2aW5nIHNlcGFyYXRlIGlvY3RsKCkgY2FsbHMgZm9yIGdldHRp
bmcgDQpzcGVjaWZpYyBkQm0vbm9pc2UgdmFsdWVzIGlmIHVzZXItc3BhY2Ug
YXBwbGljYXRpb25zIF9hbmRfIHRoZSBkcml2ZXIgDQpzdXBwb3J0cyBpdC4g
IFdlIGNhbm5vdCBoYXZlIHVzZXItc3BhY2UgYXBwbGljYXRpb25zIGd1ZXNz
aW5nIHdoaWNoIG9mIDMgDQpkaWZmZXJlbnQgcXVhbGl0eSBhbGdvcml0aG1z
IHRoZSBkcml2ZXIgaXMgcmVwb3J0aW5nLg0KDQpvICBGcmVxdWVuY3kgdmFs
dWVzIHZhcnkgd2lsZGx5IGZyb20gaXdfZ2V0X3JhbmdlDQogICAxKSBwcmlz
bTU0IHVzZXMgY29tcGxldGVseSBkaWZmZXJlbnQgZXhwb25lbnQgdmFsdWVz
IHRoYW4gYWlybw0KICAgMikgYWlybywgYXRtZWwsIG9yaW5vY28gYXJlIHRo
ZSBzYW1lDQoNCldvcmsgSXRlbTogTm9ybWFsaXplIGZyZXF1ZW5jeSB2YWx1
ZXMgYmV0d2VlbiB3aXJlbGVzcyBjYXJkcy4gIFVzZSANCmFjdHVhbCBmcmVx
dWVuY2llcyBpbiBNSHogcmF0aGVyIHRoYW4gdXNpbmcgRXhwb25lbnQgJiBN
YW50aXNzYSBmb3JtYXQgDQphcyBub3cuICBGb3JjZSB1c2VyLXNwYWNlIGFw
cGxpY2F0aW9ucyB0byBjb252ZXJ0IGNoYW5uZWxzLT5mcmVxdWVuY2llcywg
DQpiYXNlZCBvbiB3aGF0IGZyZXF1ZW5jaWVzIHRoZSBkcml2ZXIgc2F5cyBp
dCBzdXBwb3J0cy4gT3IsIGZpeCBkcml2ZXJzIA0KdG8gcmVwb3J0IEZyZXF1
ZW5jeTwtPkNoYW5uZWwgcGFpcnMgd2hlbiB0aGV5IHJlcG9ydCB0aGVpciBz
dXBwb3J0ZWQgDQpmcmVxdWVuY2llcywgYnV0IHRoZSBwb2ludCBhZ2FpbiBp
cyB0byBQSUNLIE9ORSBhbmQgbWFrZSBhbGwgZHJpdmVycyBkbyANCnRoYXQu
ICBSZW1vdmUgdGhlIGd1ZXNzaW5nLWdhbWUgZnJvbSB1c2VyLXNwYWNlIGFu
ZCBwaWNrIG9uZSBBUEkgZm9yIA0KZHJpdmVycyB0byB1c2UuDQoNCm8gIGFp
cm8vcHJpc201NCBzZWVtIHRvIGhhdmUgcHJvYmxlbXMgd2l0aCBpcDYgYW5k
IGNhdXNlIHBhbmljDQogICAxKSBTb21lIGRyaXZlcnMgZG9uJ3QgTlVMTCBv
dXQgdGhlaXIgZGF0YSBhZnRlciB0aGV5IGFyZSBkb25lIHdpdGgNCiAgICAg
IGl0LCBjYXVzaW5nIGtlcm5lbCBwYW5pY3MgbGF0ZXIgb24gZG93biB0aGUg
bGluZS4gIFNlZSBSZWQgSGF0DQogICAgICBidWd6aWxsYSAjMTM1NDMyIGZv
ciBkZXRhaWxzLCBEYXZlIEpvbmVzIGhhcyBhIHBhdGNoIGZvciB0aGUgYWly
bw0KICAgICAgZHJpdmVyIHRoYXQgc2VlbXMgdG8gd29yayBiZXR0ZXIsIHdo
aWNoIGlzIGluIFJlZCBIYXQgMi42LjEwDQogICAgICBrZXJuZWxzLg0KDQpX
b3JrIEl0ZW06IE1ha2Ugc3VyZSBhbGwgZHJpdmVycyBkaXNwb3NlIG9mIGFu
ZCBOVUxMIG91dCB0aGVpciBkYXRhIHdoZW4gDQp0aGV5IGNsb3NlLCBvciBm
aXgga2VybmVsIGFyZWFzIHRoYXQgbWlnaHQgZGVwZW5kIG9uIHRoYXQgc3Rh
bGUgZGF0YS4gIA0KT3Igd2hhdGV2ZXIgdGhlIHByb2JsZW0gaXMuDQoNCm8g
IE5vdCBhbGwgZHJpdmVycyBoYXZlIGNvcnJlY3QgbmV0bGluayBzdXBwb3J0
LCBpZiB0aGV5IGV2ZW4gaGF2ZSBpdA0KICAgMSkgb3Jpbm9jbyBpcyB0b28g
dHdpdGNoeSwgc2VuZHMgdG9vIG1hbnkgZXZlbnRzIChzaG91bGRuJ3Qgc2Vu
ZCB0aGVtDQoJCWR1cmluZyBhIHNjYW4gZm9yIGV4YW1wbGUpDQogICAyKSBh
dG1lbCwgYWlybywgYW5kIG90aGVycyBkb24ndCBzZWVtIHRvIGhhdmUgYW55
IG5ldGxpbmsgc3VwcG9ydA0KDQpXb3JrIEl0ZW06IGZpeCBhbGwgZHJpdmVy
cyB0byBlbnN1cmUgdGhhdCB3aGVuIHRoZSBjYXJkIHN1Y2Nlc3NmdWxseSAN
CmFzc29jaWF0ZXMgd2l0aCBhbiBhY2Nlc3MgcG9pbnQsIHRoYXQgaXQgc2ln
bmFscyB0aGUga2VybmVsIHRoYXQgaXRzIA0KbmV0d29yayBsaW5rIGlzICJ1
cCIuDQoNCm8gIE5vdCBhbGwgZHJpdmVycyBzdXBwb3J0IHdpcmxlc3Mgc2Nh
bm5pbmcNCiAgIDEpIG9yaW5vY28gZHJpdmVyIG1haW5seSwgc3VwcG9ydCBp
cyB1cHN0cmVhbSBhbmQgaXMgYmVpbmcgc2xvd2x5DQogICAgICBtZXJnZWQg
aW50byB0aGUga2VybmVsIGRyaXZlcg0KDQpXb3JrIEl0ZW06IFNwZWVkIHVw
IG1lcmdlIG9mIHVwc3RyZWFtIE9yaW5vY28gaW50byBrZXJuZWwgb3Jpbm9j
bw0KDQpvICBGaXJtd2FyZSBpc3N1ZXMNCiAgIDEpIENpc2NvIGFpcm9uZXQg
ZmlybXdhcmUgdXBsb2FkIGlzIHF1aXRlIGluY29uc2lzdGVudCwgZmFpbHMg
d2l0aA0KICAgICAgNS4yMSBmb3IgZXhhbXBsZS4gIEZpcm13YXJlIDw9IDUu
MDIgc2VlbXMgdG8gYmUgcmVxdWlyZWQgZm9yIHVzaW5nDQogICAgICBXRVAg
d2l0aCBtb3N0IGFjY2VzcyBwb2ludHMuICBMYXRlc3QgQ2lzY28tcHJvdmlk
ZWQgZHJpdmVyIGlzIHF1aXRlDQogICAgICBkaWZmZXJlbnQgdGhhbiBsYXRl
c3QgaW4ta2VybmVsIGRyaXZlcg0KDQpXb3JrIEl0ZW06IEZpZ3VyZSBvdXQg
bGljZW5zaW5nIGlzc3VlcyBiZXR3ZWVuIENpc2NvLXByb3ZpZGVkIGRyaXZl
ciBmb3IgDQoyLjQga2VybmVsICh3aGljaCBpcyBNUEwpIGFuZCBpbi1rZXJu
ZWwgYWlybyBkcml2ZXIgKHdoaWNoIGlzIEdQTCkuICANClRoZW4sIGZpZ3Vy
ZSBvdXQgd2hhdCBjaGFuZ2VzIHdlcmUgbWFkZSB0byB0aGUgQ2lzY28tcHJv
dmlkZWQgZHJpdmVyIHRvIA0Kc3VwcG9ydCBmaXJtd2FyZSB1cCB0byA1LjMw
LjE3LCBhbmQgbWFrZSB0aG9zZSBjaGFuZ2VzIGluIHRoZSBpbi1rZXJuZWwg
DQphaXJvIGRyaXZlci4NCg0KbyAgRXRodG9vbCBzdXBwb3J0IGZvciBhbGwg
ZHJpdmVycw0KICAgMSkgdmlybyBoYXMgZG9uZSBhIGxvdCBvZiB0aGVtLCBu
b3Qgc3VyZSBpZiB0aGlzIGlzIGNvbXBsZXRlLg0KDQpvICBBZC1Ib2MgbW9k
ZSBzdXBwb3J0IGlzIHF1aXRlIGZsYWt5IG9yIGFic2VudCBmcm9tIG1vc3Qg
ZHJpdmVycw0KICAgMSkgcHJpc201NCAibWdtdCB0eCBxdWV1ZSBmdWxsIiBl
cnJvcnMgb24gb3RoZXJ3aXNlLXdvcmtpbmcgY2FyZHMNCiAgIDIpIG1hZHdp
ZmkgcmVzZXRzIGJpdHJhdGUgdG8gMCB3aGVuIHN3aXRjaGluZyB0byBhZC1o
b2MgbW9kZQ0KDQpXb3JrIEl0ZW06IEZpeCBkcml2ZXJzIHRvIHN1cHBvcnQg
QWQtSG9jIG1vZGUsIGF0dGVtcHQgdG8gZ2V0IHNwZWNzIG9uIA0KdGhlaXIg
aGFyZHdhcmUgJiByZWdpc3RlcnMgZnJvbSBtYW51ZmFjdHVyZXJzIGlmIHdl
IGRvbid0IGhhdmUgdGhhdCANCmluZm9ybWF0aW9uIHlldCBmb3IgYWxsICJt
b2Rlcm4iIGNhcmRzLg0KDQpvICBXUEEgc3VwcG9ydCBpcyBsYWNraW5nIG9y
IGp1c3QgaW4tcHJvZ3Jlc3MsIG5lZWRzIG11Y2ggaGVscA0KICAgMSkgVGhl
IHBvaW50IGhlcmUgaXMgdGhhdCBXaXJlbGVzcyBFeHRlbnNpb25zIEFQSSBo
YXMgc2V2ZXJlbHkgbGFnZ2VkDQogICAgICBiZWhpbmQgdGhlIGNhcGFiaWxp
dGllcyBvZiBjdXJyZW50IGNoaXBzZXRzLiAgVGhlcmUgc2hvdWxkIGJlDQog
ICAgICBzdXBwb3J0IF9pbl8gV2lyZWxlc3MgRXh0ZW5zaW9ucyBmb3IgV1BB
IGFuZCBpdHMgYXNzb2NpYXRlZA0KICAgICAgdGVjaG5vbG9naWVzLCBpbnN0
ZWFkIG9mIHdoYXQgYWxsIHRoZSBkcml2ZXJzIGRvIG5vdywgd2hpY2ggaXMN
CiAgICAgIHNlcGFyYXRlLCBub24tc3RhbmRhcmQsIHByaXZhdGUgaW9jdGwo
KSBjYWxscyBmb3IgV1BBIHNldHRpbmdzLg0KDQpXb3JrIEl0ZW06IHN0YW5k
YXJkaXplIG9uIGFuIGludGVyZmFjZSBmb3IgV1BBIGFuZCBpdHMgYXNzb2Np
YXRlZCANCnRlY2hub2xvZ2llcywgYW5kIGltcGxlbWVudCB0aGF0IGludGVy
ZmFjZSBpbiBXaXJlbGVzcyBFeHRlbnNpb25zIEFQSS4gIA0KRml4IGFsbCBk
cml2ZXJzIHRvIHVzZSB0aGF0IEFQSSByYXRoZXIgdGhhbiBwcml2YXRlIGlv
Y3RsKCkgY2FsbHMuICBTb21lIA0KZHJpdmVycyB0aGF0IHN1cHBvcnQgV1BB
OiAgYXRtZWwsIG1hZHdpZmksIHByaXNtNTQsIGlwdzIyMDAuICBJdCB3b3Vs
ZCANCmFsc28gYmUgYmVuZWZpY2lhbCBpbiB0aGlzIGVmZm9ydCB0byBzdXBw
b3J0IHRoZSBjYWxscyB0aGF0IDgwMi4xeCANCnN0YWNrcyBuZWVkIChsaWtl
IHdwYV9zdXBwbGljYW50IGFuZCBPcGVuIDgwMi4xeCkgc28gdGhhdCB0aGV5
IGRvbid0IA0KaGF2ZSB0byBwYXRjaCB0aGUgZHJpdmVycyAoT3BlbiA4MDIu
MXgpIG9yIGNyZWF0ZSBzcGVjaWFsIHBlci1kcml2ZXIgDQpob29rIG1vZHVs
ZXMgKHdwYV9zdXBwbGljYW50KSB0byBiZSBhYmxlIHRvIGNhcHR1cmUgdGhl
IG5lY2Vzc2FyeSANCmF1dGhlbnRpY2F0aW9uIHBhY2tldHMgb3Igc2V0IHVw
IHRoZSBjYXJkJ3MgV1BBIHNldHRpbmdzLg0KDQpvICBEcml2ZXJzIGRlYWwg
d2l0aCBoaWRkZW4gRVNTSURzIGRpZmZlcmVudGx5DQogICAxKSBpcHcyeDAw
IHRyYXBzICIgIiBhbmQgcnVucyBvZiBcMCBhbmQgY2hhbmdlcyBpdCB0byAi
PGhpZGRlbj4iIGluDQogICAgICB0aGUgZHJpdmVyLCB3aGlsZSBvdGhlciBk
cml2ZXJzIGp1c3QgcGFzcyB0aGUgYmxhbmsgc3RyaW5nIHRocm91Z2gNCg0K
V29yayBJdGVtOiBTdGFuZGFyZGl6ZSBhbGwgZHJpdmVycyB0byBzaW1wbHkg
cGFzcyBhbiBlbXB0eSBzdHJpbmcgDQp0aHJvdWdoIHRvIHVzZXItc3BhY2Ug
d2hlbiB0aGUgYmFzZSBzdGF0aW9uIGRvZXMgbm90IGJyb2FkY2FzdCBpdHMg
DQpFU1NJRC4gIERyaXZlcnMgc2hvdWxkIF9ub3RfIGJlIGNsZXZlciBhYm91
dCB0aGlzLg0KDQoNCkxldmVscyBvZiBJbXBvcnRhbmNlIChteSBvcGluaW9u
KToNCjEpIEFsbCBkcml2ZXJzIF9NVVNUXyBzdXBwb3J0IHdpcmVsZXNzIHNj
YW5uaW5nICgqY291Z2gqIG9yaW5vY28gKmNvdWdoKikNCjIpIFdQQSBzdXBw
b3J0IG5lZWRzIHRvIGJlIHN0YW5kYXJkaXplZCBpbiBXaXJlbGVzcyBFeHRl
bnNpb25zDQozKSBDb25zaXN0ZW50IChhbmQgcHJlc2VudCkgcXVhbGl0eSBk
YXRhIGFtb25nIGRyaXZlcnMsIGJvdGggZm9yDQogICAgY3VycmVudGx5IGNv
bm5lY3RlZCBBUCBhbmQgZm9yIHNjYW5uZWQgQVBzDQo0KSBydG5ldGxpbmsg
bGluayBub3RpZmljYXRpb24gZm9yIGFsbCBkcml2ZXJzIHdoZW4gdGhleSBh
c3NvY2lhdGUgd2l0aA0KICAgIGFuIEFQDQo1KSBBZC1Ib2MgbW9kZSBzdXBw
b3J0DQo2KSBFdGh0b29sIHN1cHBvcnQNCjcpIENpc2NvIGZpcm13YXJlIGlz
c3Vlcw0KDQo=

--279707962-1485467196-1106689670=:30850--
