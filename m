Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268463AbUHLAwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268463AbUHLAwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUHLA1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:27:12 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:19945 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268366AbUHKXdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:33:53 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200408112332.i7BNWTrO080656@fsgi900.americas.sgi.com>
Subject: Re: Altix I/O code reorganization - 13 of 21
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Date: Wed, 11 Aug 2004 18:32:28 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/11 16:35:44-05:00 pfg@sgi.com 
#       clean up
# 
# arch/ia64/sn/ioif/klconfig/klconflib.c
#   2004/08/11 16:35:30-05:00 pfg@sgi.com +106 -439
#   clean up
# 
diff -Nru a/arch/ia64/sn/ioif/klconfig/klconflib.c b/arch/ia64/sn/ioif/klconfig/klconflib.c
--- a/arch/ia64/sn/ioif/klconfig/klconflib.c	2004-08-11 16:36:58 -05:00
+++ b/arch/ia64/sn/ioif/klconfig/klconflib.c	2004-08-11 16:36:58 -05:00
@@ -3,44 +3,25 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1992 - 1997, 2000-2003 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 1992 - 1997, 2000-2004 Silicon Graphics, Inc. All rights reserved.
  */
 
-
-#include <linux/types.h>
-#include <linux/ctype.h>
-#include <asm/sn/sgi.h>
 #include <asm/sn/sn_sal.h>
-#include <asm/sn/io.h>
-#include <asm/sn/sn_cpuid.h>
+#include <asm/sn/sn2/geo.h>
+#include <asm/sn/xtalk/xtalk_provider.h>
+#include <asm/sn/xtalk/xwidgetdev.h>
+#include <asm/sn/xtalk/hubdev.h>
 #include <asm/sn/iograph.h>
-#include <asm/sn/hcl.h>
-#include <asm/sn/labelcl.h>
+#include <asm/sn/sn2/shub.h>
 #include <asm/sn/klconfig.h>
-#include <asm/sn/nodepda.h>
 #include <asm/sn/module.h>
-#include <asm/sn/router.h>
-#include <asm/sn/xtalk/xbow.h>
 #include <asm/sn/ksys/l1.h>
 
-
-#undef DEBUG_KLGRAPH
-#ifdef DEBUG_KLGRAPH
-#define DBG(x...) printk(x)
-#else
-#define DBG(x...)
-#endif /* DEBUG_KLGRAPH */
-
-extern int numionodes;
-
-lboard_t *root_lboard[MAX_COMPACT_NODES];
 static int hasmetarouter;
+char brick_types[MAX_BRICK_TYPES + 1] = "cri.xdpn%#=vo^kjb7890123456789...";
+extern int numionodes;
 
-
-char brick_types[MAX_BRICK_TYPES + 1] = "crikxdpn%#=vo^34567890123456789...";
-
-lboard_t *
-find_lboard_any(lboard_t *start, unsigned char brd_type)
+lboard_t *find_lboard_any(lboard_t * start, unsigned char brd_type)
 {
 	/* Search all boards stored on this node. */
 	while (start) {
@@ -50,15 +31,15 @@
 	}
 
 	/* Didn't find it. */
-	return (lboard_t *)NULL;
+	return (lboard_t *) NULL;
 }
 
-lboard_t *
-find_lboard_nasid(lboard_t *start, nasid_t nasid, unsigned char brd_type)
+lboard_t *find_lboard_nasid(lboard_t * start, nasid_t nasid,
+			    unsigned char brd_type)
 {
 
 	while (start) {
-		if ((start->brd_type == brd_type) && 
+		if ((start->brd_type == brd_type) &&
 		    (start->brd_nasid == nasid))
 			return start;
 
@@ -69,13 +50,12 @@
 	}
 
 	/* Didn't find it. */
-	return (lboard_t *)NULL;
+	return (lboard_t *) NULL;
 }
 
-lboard_t *
-find_lboard_class_any(lboard_t *start, unsigned char brd_type)
+lboard_t *find_lboard_class_any(lboard_t * start, unsigned char brd_type)
 {
-        /* Search all boards stored on this node. */
+	/* Search all boards stored on this node. */
 	while (start) {
 		if (KLCLASS(start->brd_type) == KLCLASS(brd_type))
 			return start;
@@ -83,36 +63,15 @@
 	}
 
 	/* Didn't find it. */
-	return (lboard_t *)NULL;
-}
-
-lboard_t *
-find_lboard_class_nasid(lboard_t *start, nasid_t nasid, unsigned char brd_type)
-{
-	/* Search all boards stored on this node. */
-	while (start) {
-		if (KLCLASS(start->brd_type) == KLCLASS(brd_type) && 
-		    (start->brd_nasid == nasid))
-			return start;
-
-		if (numionodes == numnodes)
-			start = KLCF_NEXT_ANY(start);
-		else
-			start = KLCF_NEXT(start);
-	}
-
-	/* Didn't find it. */
-	return (lboard_t *)NULL;
+	return (lboard_t *) NULL;
 }
 
-
-
-klinfo_t *
-find_component(lboard_t *brd, klinfo_t *kli, unsigned char struct_type)
+klinfo_t *find_component(lboard_t * brd, klinfo_t * kli,
+			 unsigned char struct_type)
 {
 	int index, j;
 
-	if (kli == (klinfo_t *)NULL) {
+	if (kli == (klinfo_t *) NULL) {
 		index = 0;
 	} else {
 		for (j = 0; j < KLCF_NUM_COMPS(brd); j++) {
@@ -121,146 +80,22 @@
 		}
 		index = j;
 		if (index == KLCF_NUM_COMPS(brd)) {
-			DBG("find_component: Bad pointer: 0x%p\n", kli);
-			return (klinfo_t *)NULL;
+			return (klinfo_t *) NULL;
 		}
 		index++;	/* next component */
 	}
-	
-	for (; index < KLCF_NUM_COMPS(brd); index++) {		
+
+	for (; index < KLCF_NUM_COMPS(brd); index++) {
 		kli = KLCF_COMP(brd, index);
-		DBG("find_component: brd %p kli %p  request type = 0x%x kli type 0x%x\n", brd, kli, kli->struct_type, KLCF_COMP_TYPE(kli));
 		if (KLCF_COMP_TYPE(kli) == struct_type)
 			return kli;
 	}
 
 	/* Didn't find it. */
-	return (klinfo_t *)NULL;
-}
-
-klinfo_t *
-find_first_component(lboard_t *brd, unsigned char struct_type)
-{
-	return find_component(brd, (klinfo_t *)NULL, struct_type);
-}
-
-lboard_t *
-find_lboard_modslot(lboard_t *start, geoid_t geoid)
-{
-	/* Search all boards stored on this node. */
-	while (start) {
-		if (geo_cmp(start->brd_geoid, geoid))
-			return start;
-		start = KLCF_NEXT(start);
-	}
-
-	/* Didn't find it. */
-	return (lboard_t *)NULL;
-}
-
-/*
- * Convert a NIC name to a name for use in the hardware graph.
- */
-void
-nic_name_convert(char *old_name, char *new_name)
-{
-        int i;
-        char c;
-        char *compare_ptr;
-
-	if ((old_name[0] == '\0') || (old_name[1] == '\0')) {
-                strcpy(new_name, EDGE_LBL_XWIDGET);
-        } else {
-                for (i = 0; i < strlen(old_name); i++) {
-                        c = old_name[i];
-
-                        if (isalpha(c))
-                                new_name[i] = tolower(c);
-                        else if (isdigit(c))
-                                new_name[i] = c;
-                        else
-                                new_name[i] = '_';
-                }
-                new_name[i] = '\0';
-        }
-
-        /* XXX -
-         * Since a bunch of boards made it out with weird names like
-         * IO6-fibbbed and IO6P2, we need to look for IO6 in a name and
-         * replace it with "baseio" to avoid confusion in the field.
-	 * We also have to make sure we don't report media_io instead of
-	 * baseio.
-         */
-
-        /* Skip underscores at the beginning of the name */
-        for (compare_ptr = new_name; (*compare_ptr) == '_'; compare_ptr++)
-                ;
-
-	/*
-	 * Check for some names we need to replace.  Early boards
-	 * had junk following the name so check only the first
-	 * characters.
-	 */
-        if (!strncmp(new_name, "io6", 3) || 
-            !strncmp(new_name, "mio", 3) || 
-	    !strncmp(new_name, "media_io", 8))
-		strcpy(new_name, "baseio");
-	else if (!strncmp(new_name, "divo", 4))
-		strcpy(new_name, "divo") ;
-
-}
-
-/*
- * get_actual_nasid
- *
- *	Completely disabled brds have their klconfig on 
- *	some other nasid as they have no memory. But their
- *	actual nasid is hidden in the klconfig. Use this
- *	routine to get it. Works for normal boards too.
- */
-nasid_t
-get_actual_nasid(lboard_t *brd)
-{
-	klhub_t	*hub ;
-
-	if (!brd)
-		return INVALID_NASID ;
-
-	/* find out if we are a completely disabled brd. */
-
-        hub  = (klhub_t *)find_first_component(brd, KLSTRUCT_HUB);
-	if (!hub)
-                return INVALID_NASID ;
-	if (!(hub->hub_info.flags & KLINFO_ENABLE))	/* disabled node brd */
-		return hub->hub_info.physid ;
-	else
-		return brd->brd_nasid ;
-}
-
-int
-xbow_port_io_enabled(nasid_t nasid, int link)
-{
-	lboard_t *brd;
-	klxbow_t *xbow_p;
-
-	/*
-	 * look for boards that might contain an xbow or xbridge
-	 */
-	brd = find_lboard_nasid((lboard_t *)KL_CONFIG_INFO(nasid), nasid, KLTYPE_IOBRICK_XBOW);
-	if (brd == NULL) return 0;
-		
-	if ((xbow_p = (klxbow_t *)find_component(brd, NULL, KLSTRUCT_XBOW))
-	    == NULL)
-	    return 0;
-
-	if (!XBOW_PORT_TYPE_IO(xbow_p, link) || !XBOW_PORT_IS_ENABLED(xbow_p, link))
-	    return 0;
-
-	return 1;
+	return (klinfo_t *) NULL;
 }
 
-void
-board_to_path(lboard_t *brd, char *path)
+void board_to_path(lboard_t * brd, char *path)
 {
 	moduleid_t modnum;
 	char *board_name;
@@ -270,208 +105,53 @@
 
 	switch (KLCLASS(brd->brd_type)) {
 
-		case KLCLASS_NODE:
-			board_name = EDGE_LBL_NODE;
-			break;
-		case KLCLASS_ROUTER:
-			if (brd->brd_type == KLTYPE_META_ROUTER) {
-				board_name = EDGE_LBL_META_ROUTER;
-				hasmetarouter++;
-			} else if (brd->brd_type == KLTYPE_REPEATER_ROUTER) {
-				board_name = EDGE_LBL_REPEATER_ROUTER;
-				hasmetarouter++;
-			} else
-				board_name = EDGE_LBL_ROUTER;
-			break;
-		case KLCLASS_MIDPLANE:
-			board_name = EDGE_LBL_MIDPLANE;
-			break;
-		case KLCLASS_IO:
-			board_name = EDGE_LBL_IO;
-			break;
-		case KLCLASS_IOBRICK:
-			if (brd->brd_type == KLTYPE_PXBRICK)
-				board_name = EDGE_LBL_PXBRICK;
-			else if (brd->brd_type == KLTYPE_IXBRICK)
-				board_name = EDGE_LBL_IXBRICK;
-			else if (brd->brd_type == KLTYPE_OPUSBRICK)
-				board_name = EDGE_LBL_OPUSBRICK;
-			else if (brd->brd_type == KLTYPE_CGBRICK)
-				board_name = EDGE_LBL_CGBRICK;
-			else 
-				board_name = EDGE_LBL_IOBRICK;
-			break;
-		default:
-			board_name = EDGE_LBL_UNKNOWN;
+	case KLCLASS_NODE:
+		board_name = EDGE_LBL_NODE;
+		break;
+	case KLCLASS_ROUTER:
+		if (brd->brd_type == KLTYPE_META_ROUTER) {
+			board_name = EDGE_LBL_META_ROUTER;
+			hasmetarouter++;
+		} else if (brd->brd_type == KLTYPE_REPEATER_ROUTER) {
+			board_name = EDGE_LBL_REPEATER_ROUTER;
+			hasmetarouter++;
+		} else
+			board_name = EDGE_LBL_ROUTER;
+		break;
+	case KLCLASS_MIDPLANE:
+		board_name = EDGE_LBL_MIDPLANE;
+		break;
+	case KLCLASS_IO:
+		board_name = EDGE_LBL_IO;
+		break;
+	case KLCLASS_IOBRICK:
+		if (brd->brd_type == KLTYPE_PXBRICK)
+			board_name = EDGE_LBL_PXBRICK;
+		else if (brd->brd_type == KLTYPE_IXBRICK)
+			board_name = EDGE_LBL_IXBRICK;
+		else if (brd->brd_type == KLTYPE_OPUSBRICK)
+			board_name = EDGE_LBL_OPUSBRICK;
+		else if (brd->brd_type == KLTYPE_CGBRICK)
+			board_name = EDGE_LBL_CGBRICK;
+		else if (brd->brd_type == KLTYPE_SABRICK)
+			board_name = EDGE_LBL_SABRICK;
+		else if (brd->brd_type == KLTYPE_IABRICK)
+			board_name = EDGE_LBL_IABRICK;
+		else if (brd->brd_type == KLTYPE_PABRICK)
+			board_name = EDGE_LBL_PABRICK;
+		else
+			board_name = EDGE_LBL_IOBRICK;
+		break;
+	default:
+		board_name = EDGE_LBL_UNKNOWN;
 	}
-			
+
 	modnum = geo_module(brd->brd_geoid);
 	memset(buffer, 0, 16);
 	format_module_id(buffer, modnum, MODULE_FORMAT_BRIEF);
-	sprintf(path, EDGE_LBL_MODULE "/%s/" EDGE_LBL_SLAB "/%d/%s", buffer, geo_slab(brd->brd_geoid), board_name);
-}
-
-#define MHZ	1000000
-
-/*
- * Get the serial number of the main  component of a board
- * Returns 0 if a valid serial number is found
- * 1 otherwise.
- * Assumptions: Nic manufacturing string  has the following format
- *			*Serial:<serial_number>;*
- */
-static int
-component_serial_number_get(lboard_t 		*board,
-			    klconf_off_t 	mfg_nic_offset,
-			    char		*serial_number,
-			    char		*key_pattern)
-{
 
-	char	*mfg_nic_string;
-	char	*serial_string,*str;
-	int	i;
-	char	*serial_pattern = "Serial:";
-
-	/* We have an error on a null mfg nic offset */
-	if (!mfg_nic_offset)
-		return(1);
-	/* Get the hub's manufacturing nic information
-	 * which is in the form of a pre-formatted string
-	 */
-	mfg_nic_string = 
-		(char *)NODE_OFFSET_TO_K0(NASID_GET(board),
-					  mfg_nic_offset);
-	/* There is no manufacturing nic info */
-	if (!mfg_nic_string)
-		return(1);
-
-	str = mfg_nic_string;
-	/* Look for the key pattern first (if it is  specified)
-	 * and then print the serial number corresponding to that.
-	 */
-	if (strcmp(key_pattern,"") && 
-	    !(str = strstr(mfg_nic_string,key_pattern)))
-		return(1);
-
-	/* There is no serial number info in the manufacturing
-	 * nic info
-	 */
-	if (!(serial_string = strstr(str,serial_pattern)))
-		return(1);
-
-	serial_string = serial_string + strlen(serial_pattern);
-	/*  Copy the serial number information from the klconfig */
-	i = 0;
-	while (serial_string[i] != ';') {
-		serial_number[i] = serial_string[i];
-		i++;
-	}
-	serial_number[i] = 0;
-	
-	return(0);
-}
-/*
- * Get the serial number of a board
- * Returns 0 if a valid serial number is found
- * 1 otherwise.
- */
-
-int
-board_serial_number_get(lboard_t *board,char *serial_number)
-{
-	ASSERT(board && serial_number);
-	if (!board || !serial_number)
-		return(1);
-
-	strcpy(serial_number,"");
-	switch(KLCLASS(board->brd_type)) {
-	case KLCLASS_CPU: {	/* Node board */
-		klhub_t	*hub;
-		
-		/* Get the hub component information */
-		hub = (klhub_t *)find_first_component(board,
-						      KLSTRUCT_HUB);
-		/* If we don't have a hub component on an IP27
-		 * then we have a weird klconfig.
-		 */
-		if (!hub)
-			return(1);
-		/* Get the serial number information from
-		 * the hub's manufacturing nic info
-		 */
-		if (component_serial_number_get(board,
-						hub->hub_mfg_nic,
-						serial_number,
-						"IP37"))
-				return(1);
-		break;
-	}
-	case KLCLASS_IO: {	/* IO board */
-	     	klbri_t	*bridge;
-		
-		/* Get the bridge component information */
-		bridge = (klbri_t *)find_first_component(board,
-							 KLSTRUCT_BRI);
-		/* If we don't have a bridge component on an IO board
-		 * then we have a weird klconfig.
-		 */
-		if (!bridge)
-			return(1);
-		/* Get the serial number information from
-	 	 * the bridge's manufacturing nic info
-		 */
-		if (component_serial_number_get(board,
-					bridge->bri_mfg_nic,
-					serial_number, ""))
-			return(1);
-		break;
-	}
-	case KLCLASS_ROUTER: {	/* Router board */
-		klrou_t *router;	
-		
-		/* Get the router component information */
-		router = (klrou_t *)find_first_component(board,
-							 KLSTRUCT_ROU);
-		/* If we don't have a router component on a router board
-		 * then we have a weird klconfig.
-		 */
-		if (!router)
-			return(1);
-		/* Get the serial number information from
-		 * the router's manufacturing nic info
-		 */
-		if (component_serial_number_get(board,
-						router->rou_mfg_nic,
-						serial_number,
-						""))
-			return(1);
-		break;
-	}
-	case KLCLASS_GFX: {	/* Gfx board */
-		klgfx_t *graphics;
-		
-		/* Get the graphics component information */
-		graphics = (klgfx_t *)find_first_component(board, KLSTRUCT_GFX);
-		/* If we don't have a gfx component on a gfx board
-		 * then we have a weird klconfig.
-		 */
-		if (!graphics)
-			return(1);
-		/* Get the serial number information from
-		 * the graphics's manufacturing nic info
-		 */
-		if (component_serial_number_get(board,
-						graphics->gfx_mfg_nic,
-						serial_number,
-						""))
-			return(1);
-		break;
-	}
-	default:
-		strcpy(serial_number,"");
-		break;
-	}
-	return(0);
+	sprintf(path, EDGE_LBL_MODULE "/%s/" EDGE_LBL_SLAB "/%d/%s", buffer,
+		geo_slab(brd->brd_geoid), board_name);
 }
 
 /*
@@ -494,8 +174,7 @@
  *				the corresponding brick, eg. still 002c15
  *				for a C-brick, but 101p17 for a PX-brick.
  */
-void
-format_module_id(char *buffer, moduleid_t m, int fmt)
+void format_module_id(char *buffer, moduleid_t m, int fmt)
 {
 	int rack, position;
 	unsigned char brickchar;
@@ -505,68 +184,56 @@
 	brickchar = MODULE_GET_BTCHAR(m);
 
 	if (fmt == MODULE_FORMAT_LCD) {
-	    /* Be sure we use the same brick type character as displayed
-	     * on the brick's LCD
-	     */
-	    switch (brickchar) 
-	    {
-	    case L1_BRICKTYPE_PX:
-		brickchar = L1_BRICKTYPE_P;
-		break;
+		/* Be sure we use the same brick type character as displayed
+		 * on the brick's LCD
+		 */
+		switch (brickchar) {
+		case L1_BRICKTYPE_PX:
+		case L1_BRICKTYPE_PE:
+		case L1_BRICKTYPE_PA:
+		case L1_BRICKTYPE_SA:	/* we can move this to the "I's" later
+					 * if that makes more sense
+					 */
+			brickchar = L1_BRICKTYPE_P;
+			break;
 
-	    case L1_BRICKTYPE_IX:
-		brickchar = L1_BRICKTYPE_I;
-		break;
-	    }
+		case L1_BRICKTYPE_IX:
+		case L1_BRICKTYPE_IA:
+
+			brickchar = L1_BRICKTYPE_I;
+			break;
+		}
 	}
 
 	position = MODULE_GET_BPOS(m);
 
 	if ((fmt == MODULE_FORMAT_BRIEF) || (fmt == MODULE_FORMAT_LCD)) {
-	    /* Brief module number format, eg. 002c15 */
-
-	    /* Decompress the rack number */
-	    *buffer++ = '0' + RACK_GET_CLASS(rack);
-	    *buffer++ = '0' + RACK_GET_GROUP(rack);
-	    *buffer++ = '0' + RACK_GET_NUM(rack);
-
-	    /* Add the brick type */
-	    *buffer++ = brickchar;
-	}
-	else if (fmt == MODULE_FORMAT_LONG) {
-	    /* Fuller hwgraph format, eg. rack/002/bay/15 */
-
-	    strcpy(buffer, EDGE_LBL_RACK "/");  buffer += strlen(buffer);
+		/* Brief module number format, eg. 002c15 */
 
-	    *buffer++ = '0' + RACK_GET_CLASS(rack);
-	    *buffer++ = '0' + RACK_GET_GROUP(rack);
-	    *buffer++ = '0' + RACK_GET_NUM(rack);
+		/* Decompress the rack number */
+		*buffer++ = '0' + RACK_GET_CLASS(rack);
+		*buffer++ = '0' + RACK_GET_GROUP(rack);
+		*buffer++ = '0' + RACK_GET_NUM(rack);
+
+		/* Add the brick type */
+		*buffer++ = brickchar;
+	} else if (fmt == MODULE_FORMAT_LONG) {
+		/* Fuller hwgraph format, eg. rack/002/bay/15 */
+
+		strcpy(buffer, EDGE_LBL_RACK "/");
+		buffer += strlen(buffer);
+
+		*buffer++ = '0' + RACK_GET_CLASS(rack);
+		*buffer++ = '0' + RACK_GET_GROUP(rack);
+		*buffer++ = '0' + RACK_GET_NUM(rack);
 
-	    strcpy(buffer, "/" EDGE_LBL_RPOS "/");  buffer += strlen(buffer);
+		strcpy(buffer, "/" EDGE_LBL_RPOS "/");
+		buffer += strlen(buffer);
 	}
 
 	/* Add the bay position, using at least two digits */
 	if (position < 10)
-	    *buffer++ = '0';
+		*buffer++ = '0';
 	sprintf(buffer, "%d", position);
 
-}
-
-int
-cbrick_type_get_nasid(nasid_t nasid)
-{
-	moduleid_t module;
-	int t;
-
-	module = iomoduleid_get(nasid);
-	if (module < 0 ) {
-		return MODULE_CBRICK;
-	}
-	t = MODULE_GET_BTYPE(module);
-	if ((char)t == 'o') {
-		return MODULE_OPUSBRICK;
-	} else {
-		return MODULE_CBRICK;
-	}
-	return -1;
 }
